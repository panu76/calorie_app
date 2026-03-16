import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import '../models/food_item.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../datasources/food_local_datasource.dart';
import '../datasources/food_prefs_datasource.dart';
import '../datasources/food_remote_datasource.dart';
import '../services/food_service.dart';

abstract class FoodStorage {
  Future<List<FoodItem>> getDailyMeals(DateTime date);
  Future<void> insertMeal(FoodItem item);
  Future<void> deleteMeal(FoodItem item);
  Future<void> updateMeal(FoodItem item);
}

class FoodRepository {
  final FoodService _foodService;
  final FoodRemoteDataSource _remoteDataSource;
  final FoodStorage _storage;

  FoodRepository(this._foodService, this._remoteDataSource)
    : _storage = kIsWeb ? FoodPrefsDataSource() : FoodLocalDataSource();

  Future<List<FoodItem>> getDailyFoodLog(DateTime date) async {
    return _storage.getDailyMeals(date);
  }

  Future<void> addFoodItem(FoodItem item) async {
    await _storage.insertMeal(item);
  }

  Future<Either<String, FoodItem>> detectFoodFromImage(
    Uint8List imageBytes,
  ) async {
    return await _foodService.detectFoodAndCalories(imageBytes);
  }

  Future<void> deleteFoodItem(FoodItem item) async {
    await _storage.deleteMeal(item);
  }

  Future<void> updateFoodItem(FoodItem item) async {
    await _storage.updateMeal(item);
  }

  Future<List<dynamic>> fetchSampleMealsFromApi() {
    return _remoteDataSource.fetchSampleMeals();
  }
}
