import 'package:dio/dio.dart';

class FoodRemoteDataSource {
  final Dio dio;

  FoodRemoteDataSource(this.dio);

  Future<List<dynamic>> fetchSampleMeals() async {
    // Example REST call – replace with your real endpoint if available.
    try {
      final response = await dio.get('/todos?_limit=3');
      final data = response.data;
      if (data is List) {
        return data;
      }
      return const [];
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}

