import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/category.dart';


class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({required this.category, super.key});


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: CachedNetworkImage(
              imageUrl: category.thumb,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (c, u) => const Center(child: CircularProgressIndicator()),
              errorWidget: (c, u, e) => const Center(child: Icon(Icons.image_not_supported)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(category.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(category.description, maxLines: 2, overflow: TextOverflow.ellipsis),
          ]),
        )
      ]),
    );
  }
}