import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/api_s.dart';
import 'screens/home_screen.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
      create: (_) => ApiService(),
      child: MaterialApp(
        title: 'Рецепти',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}