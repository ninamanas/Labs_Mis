import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_s.dart';
import '../models/category.dart';
import '../services/notifications_service.dart';
import '../widgets/category_card.dart';
import 'category_screen.dart';
import 'detalen_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Category>> _future;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _future = Provider.of<ApiService>(context, listen: false).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории'),
        actions: [

          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          ),


          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () async {
              try {
                final meal = await api.fetchRandomMeal();
                if (!mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailScreen(meal: meal)),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Грешка при вчитување: $e')),
                );
              }
            },
          ),


          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () async {
              final meal = await api.fetchRandomMeal();
              await NotificationsService.showNotification(
                title: 'Рецепт на денот',
                body: meal.name,
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // Пребарување
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Пребарај категории',
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),


          Expanded(
            child: FutureBuilder<List<Category>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Грешка: ${snapshot.error}'));
                }

                final cats = (snapshot.data ?? [])
                    .where((c) => c.name.toLowerCase().contains(_query.toLowerCase()))
                    .toList();

                if (cats.isEmpty) {
                  return const Center(child: Text('Нема категории'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.95,
                  ),
                  itemCount: cats.length,
                  itemBuilder: (context, i) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryScreen(category: cats[i].name),
                        ),
                      );
                    },
                    child: CategoryCard(category: cats[i]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
