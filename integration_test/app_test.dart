import 'package:calorie_lens/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('end-to-end add meal flow', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Open manual add form from home screen AppBar action
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Test Meal');
    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Test Meal'), findsWidgets);
  });
}

