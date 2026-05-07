import 'package:cours/main.dart';
import 'package:cours/notifiers/session_notifier.dart';
import 'package:cours/notifiers/theme_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login Screen Process', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
          ChangeNotifierProvider<SessionNotifier>(
            create: (_) => SessionNotifier(),
          ),
        ],
        child: const MyApp(),
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.enterText(
      find.byKey(const ValueKey('email_field')),
      'thomas.coichot@decode.com',
    );

    await tester.enterText(
      find.byKey(const ValueKey('password_field')),
      'Password123&',
    );

    expect(find.text('thomas.coichot@decode.com'), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.tap(find.byKey(const ValueKey('login_button')));

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byKey(const ValueKey('home_screen')), findsOneWidget);
  });
}
