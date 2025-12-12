class FavoriteMeal {
  final String id;
  final String name;
  final String thumb;

  FavoriteMeal({required this.id, required this.name, required this.thumb});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'thumb': thumb};
  }

  factory FavoriteMeal.fromMap(Map<String, dynamic> map) {
    return FavoriteMeal(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      thumb: map['thumb'] ?? '',
    );
  }
}
