import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:onyx_restaurant/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Navigasi dari Home ke Settings berhasil', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    expect(find.text('Dark Mode'), findsNothing);

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Dark Mode'), findsOneWidget);
  });
}
