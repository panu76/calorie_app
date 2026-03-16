import 'package:calorie_lens/data/models/food_item.dart';
import 'package:calorie_lens/data/repositories/food_repository.dart';
import 'package:calorie_lens/presentation/cubit/food_log_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFoodRepository extends Mock implements FoodRepository {}

void main() {
  late FoodLogCubit cubit;
  late MockFoodRepository repository;

  setUp(() {
    repository = MockFoodRepository();
    cubit = FoodLogCubit(repository);
  });

  test('loadDailyLog loads meals from repository', () async {
    when(() => repository.getDailyFoodLog(any())).thenAnswer((_) async => <FoodItem>[]);

    await cubit.loadDailyLog();

    expect(cubit.state.isLoading, false);
    expect(cubit.state.meals, isEmpty);
    verify(() => repository.getDailyFoodLog(any())).called(1);
  });
}

