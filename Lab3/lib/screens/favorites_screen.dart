import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/favorites_provider.dart';
import '../models/favorite_meal.dart';
import '../services/api_s.dart';
import 'detalen_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Омилени рецепти')),
      body: Consumer<FavoritesProvider>(
        builder: (context, favorites, _) {
          if (favorites.favorites.isEmpty) return const Center(child: Text('Нема омилени рецепти'));

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
            ),
            itemCount: favorites.favorites.length,
            itemBuilder: (context, i) {
              final meal = favorites.favorites[i];
              return GestureDetector(
                onTap: () async {
                  try {
                    final detail = await api.fetchMealDetail(meal.id);
                    if (!context.mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailScreen(meal: detail)),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Грешка: $e')));
                  }
                },
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(meal.thumb, fit: BoxFit.cover, width: double.infinity),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(meal.name, maxLines: 2, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
