class MealSummary {
  final String id;
  final String name;
  final String thumb;


  MealSummary({required this.id, required this.name, required this.thumb});


  factory MealSummary.fromJson(Map<String, dynamic> j) => MealSummary(
    id: j['idMeal'] as String,
    name: j['strMeal'] as String,
    thumb: j['strMealThumb'] as String,
  );
}