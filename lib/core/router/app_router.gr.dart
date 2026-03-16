// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddMealFormRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddMealFormScreen(),
      );
    },
    EditMealRoute.name: (routeData) {
      final args = routeData.argsAs<EditMealRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditMealScreen(
          key: args.key,
          meal: args.meal,
        ),
      );
    },
    GraphRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GraphScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    MealDetailRoute.name: (routeData) {
      final args = routeData.argsAs<MealDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MealDetailScreen(
          key: args.key,
          meal: args.meal,
        ),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingScreen(),
      );
    },
    ReceiptScannerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ReceiptScannerScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
  };
}

/// generated route for
/// [AddMealFormScreen]
class AddMealFormRoute extends PageRouteInfo<void> {
  const AddMealFormRoute({List<PageRouteInfo>? children})
      : super(
          AddMealFormRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddMealFormRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditMealScreen]
class EditMealRoute extends PageRouteInfo<EditMealRouteArgs> {
  EditMealRoute({
    Key? key,
    required FoodItem meal,
    List<PageRouteInfo>? children,
  }) : super(
          EditMealRoute.name,
          args: EditMealRouteArgs(
            key: key,
            meal: meal,
          ),
          initialChildren: children,
        );

  static const String name = 'EditMealRoute';

  static const PageInfo<EditMealRouteArgs> page =
      PageInfo<EditMealRouteArgs>(name);
}

class EditMealRouteArgs {
  const EditMealRouteArgs({
    this.key,
    required this.meal,
  });

  final Key? key;

  final FoodItem meal;

  @override
  String toString() {
    return 'EditMealRouteArgs{key: $key, meal: $meal}';
  }
}

/// generated route for
/// [GraphScreen]
class GraphRoute extends PageRouteInfo<void> {
  const GraphRoute({List<PageRouteInfo>? children})
      : super(
          GraphRoute.name,
          initialChildren: children,
        );

  static const String name = 'GraphRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MealDetailScreen]
class MealDetailRoute extends PageRouteInfo<MealDetailRouteArgs> {
  MealDetailRoute({
    Key? key,
    required FoodItem meal,
    List<PageRouteInfo>? children,
  }) : super(
          MealDetailRoute.name,
          args: MealDetailRouteArgs(
            key: key,
            meal: meal,
          ),
          initialChildren: children,
        );

  static const String name = 'MealDetailRoute';

  static const PageInfo<MealDetailRouteArgs> page =
      PageInfo<MealDetailRouteArgs>(name);
}

class MealDetailRouteArgs {
  const MealDetailRouteArgs({
    this.key,
    required this.meal,
  });

  final Key? key;

  final FoodItem meal;

  @override
  String toString() {
    return 'MealDetailRouteArgs{key: $key, meal: $meal}';
  }
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReceiptScannerScreen]
class ReceiptScannerRoute extends PageRouteInfo<void> {
  const ReceiptScannerRoute({List<PageRouteInfo>? children})
      : super(
          ReceiptScannerRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReceiptScannerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
