import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/meal_model.dart';

/// Local cache for meals stored in SharedPreferences as JSON.
class MealLocalDataSource {
  final SharedPreferences _prefs;
  static const _cacheKey = 'cached_meals';

  const MealLocalDataSource(this._prefs);

  Future<List<MealModel>> getCachedMeals() async {
    final jsonStr = _prefs.getString(_cacheKey);
    if (jsonStr == null) return [];
    try {
      final list = json.decode(jsonStr) as List<dynamic>;
      return list
          .whereType<Map<String, dynamic>>()
          .map(MealModel.fromJson)
          .toList();
    } catch (_) {
      // Malformed or outdated JSON — treat as empty cache.
      return [];
    }
  }

  Future<void> cacheMeals(List<MealModel> meals) async {
    final jsonStr = json.encode(meals.map((m) => m.toJson()).toList());
    await _prefs.setString(_cacheKey, jsonStr);
  }
}
