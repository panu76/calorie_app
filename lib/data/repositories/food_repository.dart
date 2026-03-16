import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import '../models/food_item.dart';
import '../datasources/food_local_datasource.dart';
import '../datasources/food_remote_datasource.dart';
import '../services/food_service.dart';

class FoodRepository {
  final FoodService _foodService;
  final FoodLocalDataSource _localDataSource;
  final FoodRemoteDataSource _remoteDataSource;
  
  FoodRepository(
    this._foodService,
    this._localDataSource,
    this._remoteDataSource,
  );

  Future<List<FoodItem>> getDailyFoodLog(DateTime date) async {
    return _localDataSource.getDailyMeals(date);
  }

  Future<void> addFoodItem(FoodItem item) async {
    await _localDataSource.insertMeal(item);
  }

  Future<Either<String, FoodItem>> detectFoodFromImage(Uint8List imageBytes) async {
    return await _foodService.detectFoodAndCalories(imageBytes);
  }

  Future<void> deleteFoodItem(FoodItem item) async {
    await _localDataSource.deleteMeal(item);
  }

  Future<void> updateFoodItem(FoodItem item) async {
    await _localDataSource.updateMeal(item);
  }

  Future<List<dynamic>> fetchSampleMealsFromApi() {
    return _remoteDataSource.fetchSampleMeals();
  }
}