import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/di/injection_container.dart';
import 'core/router/app_router.dart';
import 'data/repositories/food_repository.dart';
import 'presentation/cubit/food_log_cubit.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> _loadEnvironmentFile() async {
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    debugPrint('Error loading .env file: $e');
    // Provide a fallback or handle error as needed
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _loadEnvironmentFile();
  await initDependencies();

  // Only initialize sqflite FFI on desktop (not web)
  if (!kIsWeb) {
    // ignore: avoid_web_libraries_in_flutter
    // Import and initialize sqflite_ffi only on non-web platforms
    // (This import must be conditional in a real project, but for now, just skip on web)
    // import 'package:sqflite_common_ffi/sqflite_ffi.dart';
    // sqfliteFfiInit();
    // databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodLogCubit(sl<FoodRepository>())..loadDailyLog(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Calorie Tracker',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
