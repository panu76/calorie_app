import 'package:calorie_lens/presentation/screens/add_meal_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows validation errors when fields are empty', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AddMealFormScreen(),
      ),
    );

    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('Please enter a food name'), findsOneWidget);
    expect(find.text('Enter a valid calorie value'), findsOneWidget);
  });
}

