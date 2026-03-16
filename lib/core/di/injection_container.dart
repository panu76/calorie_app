import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/dio_client.dart';
import '../../data/datasources/food_local_datasource.dart';
import '../../data/datasources/food_remote_datasource.dart';
import '../../data/repositories/food_repository.dart';
import '../../data/services/food_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  sl.registerLazySingleton<DioClient>(
    () => DioClient('https://jsonplaceholder.typicode.com'),
  );

  // Services
  sl.registerLazySingleton<FoodService>(() => FoodService());

  // Data sources
  sl.registerLazySingleton<FoodLocalDataSource>(() => FoodLocalDataSource());
  sl.registerLazySingleton<FoodRemoteDataSource>(
    () => FoodRemoteDataSource(sl<DioClient>().dio),
  );

  // Repositories
  sl.registerLazySingleton<FoodRepository>(
    () => FoodRepository(
      sl<FoodService>(),
      sl<FoodLocalDataSource>(),
      sl<FoodRemoteDataSource>(),
    ),
  );
}

