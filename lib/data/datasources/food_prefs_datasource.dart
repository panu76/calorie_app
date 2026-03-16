import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/food_item.dart';

import '../repositories/food_repository.dart';

class FoodPrefsDataSource implements FoodStorage {
  static const _key = 'meals';

  Future<List<FoodItem>> getDailyMeals(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    final mealsJson = prefs.getStringList(_key) ?? [];
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(Duration(days: 1));
    return mealsJson
        .map((e) => FoodItem.fromJson(jsonDecode(e)))
        .where(
          (item) =>
              item.timestamp.isAfter(
                start.subtract(const Duration(milliseconds: 1)),
              ) &&
              item.timestamp.isBefore(end),
        )
        .toList();
  }

  Future<void> insertMeal(FoodItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final mealsJson = prefs.getStringList(_key) ?? [];
    mealsJson.add(jsonEncode(item.toJson()));
    await prefs.setStringList(_key, mealsJson);
  }

  Future<void> deleteMeal(FoodItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final mealsJson = prefs.getStringList(_key) ?? [];
    mealsJson.removeWhere(
      (e) => FoodItem.fromJson(jsonDecode(e)).id == item.id,
    );
    await prefs.setStringList(_key, mealsJson);
  }

  Future<void> updateMeal(FoodItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final mealsJson = prefs.getStringList(_key) ?? [];
    final idx = mealsJson.indexWhere(
      (e) => FoodItem.fromJson(jsonDecode(e)).id == item.id,
    );
    if (idx != -1) {
      mealsJson[idx] = jsonEncode(item.toJson());
      await prefs.setStringList(_key, mealsJson);
    }
  }
}
