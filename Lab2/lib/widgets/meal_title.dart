import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/meal_sum.dart';


class MealTile extends StatelessWidget {
  final MealSummary meal;
  const MealTile({required this.meal, super.key});


  @override
  Widget build(BuildContext context) {
    return Card(
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
        Padding(padding: const EdgeInsets.all(8.0), child: Text(meal.name, maxLines: 2, overflow: TextOverflow.ellipsis)),
      ]),
    );
  }
}