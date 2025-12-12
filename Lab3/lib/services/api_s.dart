import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal_sum.dart';
import '../models/meal_detali.dart';

class ApiService {
  static const _base = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Category>> fetchCategories() async {
    final resp = await http.get(Uri.parse('$_base/categories.php'));
    if (resp.statusCode != 200) throw Exception('Failed to load categories');
    final j = jsonDecode(resp.body) as Map<String, dynamic>;
    final list = j['categories'] as List<dynamic>;
    return list.map((e) => Category.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<MealSummary>> fetchMealsByCategory(String category) async {
    final resp = await http.get(
      Uri.parse('$_base/filter.php?c=${Uri.encodeComponent(category)}'),
    );
    if (resp.statusCode != 200) throw Exception('Failed to load meals of category');
    final j = jsonDecode(resp.body) as Map<String, dynamic>;
    final list = j['meals'] as List<dynamic>?;
    if (list == null) return [];
    return list.map((e) => MealSummary.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<MealSummary>> searchMeals(String query) async {
    final resp = await http.get(
      Uri.parse('$_base/search.php?s=${Uri.encodeComponent(query)}'),
    );
    if (resp.statusCode != 200) throw Exception('Failed to search meals');
    final j = jsonDecode(resp.body) as Map<String, dynamic>;
    final list = j['meals'] as List<dynamic>?;
    if (list == null) return [];
    return list.map((e) => MealSummary.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<MealDetail> fetchMealDetail(String id) async {
    final resp = await http.get(
      Uri.parse('$_base/lookup.php?i=${Uri.encodeComponent(id)}'),
    );
    if (resp.statusCode != 200) throw Exception('Failed to load meal detail');
    final j = jsonDecode(resp.body) as Map<String, dynamic>;
    final list = j['meals'] as List<dynamic>?;
    if (list == null || list.isEmpty) throw Exception('Meal not found');
    return MealDetail.fromJson(list.first as Map<String, dynamic>);
  }

  Future<MealDetail> fetchRandomMeal() async {
    final resp = await http.get(
      Uri.parse('$_base/random.php'),
    );
    if (resp.statusCode != 200) throw Exception('Failed to load random meal');
    final j = jsonDecode(resp.body) as Map<String, dynamic>;
    final list = j['meals'] as List<dynamic>;
    return MealDetail.fromJson(list.first as Map<String, dynamic>);
  }
}
