import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_s.dart';
import '../models/meal_sum.dart';
import '../widgets/meal_title.dart';
import 'detalen_screen.dart';


class CategoryScreen extends StatefulWidget {
  final String category;
  const CategoryScreen({required this.category, super.key});


  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}


class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<MealSummary>> _future;
  String _query = '';


  @override
  void initState() {
    super.initState();
    _future = Provider.of<ApiService>(context, listen: false).fetchMealsByCategory(widget.category);
  }


  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Пребарај јадења'),
            onChanged: (v) async {
              setState(() => _query = v);
              if (v.trim().isEmpty) {
                setState(() => _future = api.fetchMealsByCategory(widget.category));
              } else {
                setState(() => _future = api.searchMeals(v));
              }
            },
          ),
        ),
        Expanded(
          child: FutureBuilder<List<MealSummary>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
              if (snapshot.hasError) return Center(child: Text('Грешка: \${snapshot.error}'));
              final meals = snapshot.data ?? [];
              if (meals.isEmpty) return const Center(child: Text('Нема јадења'));
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.85),
                itemCount: meals.length,
                itemBuilder: (context, i) => GestureDetector(
                  onTap: () async {
                    try {
                      final detail = await api.fetchMealDetail(meals[i].id);
                      if (!mounted) return;
                      Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(meal: detail)));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Грешка при вчитување на рецепт: \$e')));
                    }
                  },
                  child: MealTile(meal: meals[i]),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}