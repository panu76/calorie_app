import 'package:auto_route/auto_route.dart';

import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/main_screen.dart';
import '../../presentation/screens/onboarding_screen.dart';
import '../../presentation/screens/settings_screen.dart';
import '../../presentation/screens/meal_detail_screen.dart';
import '../../presentation/screens/add_meal_form_screen.dart';
import '../../presentation/screens/receipt_scanner_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnboardingRoute.page, initial: true),
        AutoRoute(page: MainRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: MealDetailRoute.page),
        AutoRoute(page: AddMealFormRoute.page),
        AutoRoute(page: ReceiptScannerRoute.page),
      ];
}

