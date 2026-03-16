import 'dart:convert';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../models/food_item.dart';

class FoodService {
  final String _model = 'gemini-1.5-flash';

  // Load the API key from the environment
  String get _apiKey => dotenv.env['GOOGLE_AI_API_KEY'] ?? '';

  // Initialize Gemini in the constructor
  FoodService() {
    if (_apiKey.isEmpty) {
      throw Exception('Google AI API key not found in environment variables');
    }

    // Initialize the Gemini instance
    Gemini.init(apiKey: _apiKey);
  }

  Future<Either<String, FoodItem>> detectFoodAndCalories(Uint8List imageBytes) async {
    if (imageBytes.isEmpty) {
      return Left('Image data is empty');
    }

    // Gemini free tier has strict rate limits. Retry once with a short delay if we hit 429.
    const maxAttempts = 2;
    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        final response = await Gemini.instance.prompt(
          parts: [
            Part.text(
              'Analyze this image and identify the food. '
              'Estimate its calories, protein, carbs, and fat. '
              'Return JSON in this format: {"name": "food name", "calories": 100, "protein": 10, "carbs": 20, "fat": 5}. '
              'If you cannot identify food in the image or it is not a clear food photo, return {"name": "Unable to identify food", "calories": 0, "protein": 0, "carbs": 0, "fat": 0}.',
            ),
            Part.bytes(imageBytes),
          ],
          model: _model,
        );

        final output = response?.output;
        if (output == null || output.isEmpty) {
          return Left('No response output from Gemini API');
        }

        final match = RegExp(r'\{.*\}').firstMatch(output);
        if (match == null) {
          return Left('No valid JSON found in output: $output');
        }

        final foodData = jsonDecode(match.group(0)!);

        if (foodData['name'] == 'Unable to identify food') {
          return Left('Unable to identify food in the image. Please provide a clear photo of food.');
        }

        return Right(FoodItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: foodData['name'],
          calories: (foodData['calories'] as num).toDouble(),
          protein: (foodData['protein'] as num).toDouble(),
          carbs: (foodData['carbs'] as num).toDouble(),
          fat: (foodData['fat'] as num).toDouble(),
          quantity: 100.0,
          timestamp: DateTime.now(),
        ));
      } catch (e) {
        final errorMessage = e.toString();

        final isRateLimitError =
            errorMessage.contains('429') || errorMessage.contains('Too Many Requests');

        if (isRateLimitError && attempt < maxAttempts) {
          // Wait a short amount of time before retrying
          await Future.delayed(Duration(seconds: 2 * attempt));
          continue;
        }

        if (isRateLimitError) {
          return Left('API quota exceeded. The free tier has rate limits. Please wait a few minutes before trying again.');
        }

        return Left('Failed to detect food: $errorMessage');
      }
    }

    return Left('Failed to detect food after retrying. Please try again later.');
  }
}

