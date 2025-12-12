import 'package:flutter/material.dart';
import '../models/favorite_meal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<FavoriteMeal> _favorites = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userId;

  FavoritesProvider({ this.userId}) {
    loadFavorites();
  }

  List<FavoriteMeal> get favorites => _favorites;

  bool isFavorite(String id) => _favorites.any((meal) => meal.id == id);

  Future<void> addFavorite(FavoriteMeal meal) async {
    if (!isFavorite(meal.id)) {
      _favorites.add(meal);
      notifyListeners();
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(meal.id)
          .set(meal.toMap());
    }
  }

  Future<void> removeFavorite(String id) async {
    _favorites.removeWhere((meal) => meal.id == id);
    notifyListeners();
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(id)
        .delete();
  }

  Future<void> loadFavorites() async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();
    _favorites.clear();
    for (var doc in snapshot.docs) {
      _favorites.add(FavoriteMeal.fromMap(doc.data()));
    }
    notifyListeners();
  }
}
