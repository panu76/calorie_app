import 'package:flutter/material.dart';
import '../../data/models/food_item.dart';
import 'package:auto_route/auto_route.dart';

import '../../presentation/screens/screens.dart';

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
