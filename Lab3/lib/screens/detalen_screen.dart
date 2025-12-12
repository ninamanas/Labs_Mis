import 'package:flutter/material.dart';
import '../models/meal_detali.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';


class DetailScreen extends StatelessWidget {
  final MealDetail meal;
  const DetailScreen({required this.meal, super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(imageUrl: meal.thumb, height: 220, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(meal.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text("Категорија: ${meal.category} • Област: ${meal.area}"),
          const SizedBox(height: 12),
          const Text('Состојки:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          ...meal.ingredients.map((m) {
            final key = m.keys.first;
            final value = m.values.first;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text('- $key: $value'),
            );
          }).toList(),
          const SizedBox(height: 12),
          const Text('Инструкции:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(meal.instructions),
          const SizedBox(height: 12),
          if (meal.youtube.isNotEmpty) ...[
            const Text('Видео:', style: TextStyle(fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () async {
                final uri = Uri.tryParse(meal.youtube);
                if (uri != null && await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              child: Text(meal.youtube),
            )
          ]
        ]),
      ),
    );
  }
}