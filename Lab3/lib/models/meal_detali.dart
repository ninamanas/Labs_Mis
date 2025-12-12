class MealDetail {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumb;
  final String youtube;
  final List<Map<String, String>> ingredients;

  MealDetail({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumb,
    required this.youtube,
    required this.ingredients,
  });

  factory MealDetail.fromJson(Map<String, dynamic> j) {
    final parsedIngredients = <Map<String, String>>[];

    // parsiranje
    for (var i = 1; i <= 20; i++) {
      final ingKey = 'strIngredient$i';
      final meaKey = 'strMeasure$i';

      final ingVal = j[ingKey];
      final meaVal = j[meaKey];

      if (ingVal != null &&
          ingVal.toString().trim().isNotEmpty &&
          ingVal.toString() != "null") {
        parsedIngredients.add({
          ingVal.toString(): (meaVal ?? '').toString(),
        });
      }
    }

    return MealDetail(
      id: j['idMeal'] ?? '',
      name: j['strMeal'] ?? '',
      category: j['strCategory'] ?? '',
      area: j['strArea'] ?? '',
      instructions: j['strInstructions'] ?? '',
      thumb: j['strMealThumb'] ?? '',
      youtube: j['strYoutube'] ?? '',
      ingredients: parsedIngredients,
    );
  }
}
