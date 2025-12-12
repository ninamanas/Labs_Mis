import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

import 'services/api_s.dart';
import 'services/favorites_provider.dart';
import 'services/notifications_service.dart';

import 'screens/home_screen.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (message.notification != null) {
    await NotificationsService.showNotification(
      title: message.notification!.title ?? "Нотификација",
      body: message.notification!.body ?? "",
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationsService.init();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        Provider<ApiService>(create: (_) => ApiService()),
        ChangeNotifierProvider<FavoritesProvider>(create: (_) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    _requestPermission();
    _setupForegroundFCMListener();

    // TEST kje se pushti po 1 min
    scheduleTestNotification();
  }


  void scheduleTestNotification() async {
    final api = Provider.of<ApiService>(context, listen: false);
    try {
      final meal = await api.fetchRandomMeal();
      final now = DateTime.now();
      final nextMinute = now.add(const Duration(minutes: 1));

      await NotificationsService.scheduleOneTimeNotification(
        dateTime: nextMinute,
        title: "Рецепт на денот",
        body: meal.name,
      );
    } catch (e) {
      print("Грешка при добивање на случаен рецепт: $e");
    }
  }


  void _requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );

    print("Notification permission: ${settings.authorizationStatus}");
  }


  void _setupForegroundFCMListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        NotificationsService.showNotification(
          title: message.notification!.title ?? "Нотификација",
          body: message.notification!.body ?? "",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Рецепти",
      home: const HomeScreen(),
    );
  }
}
