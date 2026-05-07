import 'package:cours/widgets/buttons/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoadingButton Widget Tests', () {
    testWidgets('Displays CircularProgressIndicator when isLoading is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: .ltr,
          child: LoadingButton(
            isLoading: true,
            onPressed: () {},
            label: 'Submit',
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Submit'), findsNothing);
    });
  });
}
