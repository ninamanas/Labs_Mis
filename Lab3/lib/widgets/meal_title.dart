import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/meal_sum.dart';
import '../services/favorites_provider.dart';
import '../models/favorite_meal.dart';

class MealTile extends StatelessWidget {
  final MealSummary meal;
  const MealTile({required this.meal, super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesProvider>(context);
    final isFav = favorites.isFavorite(meal.id);

    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: meal.thumb,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (c, u) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (c, u, e) => const Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(meal.name, maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          ]),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.red),
            onPressed: () async {
              if (isFav) {
                await favorites.removeFavorite(meal.id);
              } else {
                await favorites.addFavorite(FavoriteMeal(
                  id: meal.id,
                  name: meal.name,
                  thumb: meal.thumb,
                ));
              }
            },
          ),
        ),
      ],
    );
  }
}
