import 'package:abcjobs_movil/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Pruebas agendadas',
            (tester) async {
          // Load app widget.
          await tester.pumpWidget(const ABCJobsApp());

          /// Ahora hace login
          await tester.pumpAndSettle(const Duration(seconds: 2));
          await tester.enterText(find.byKey(const Key('_email')), "candidato2@test.com");
          await tester.enterText(find.byKey(const Key('_password')), "test");
          await tester.pumpAndSettle();
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pumpAndSettle();
          await tester.tap(find.byKey(const Key('_btnAutenticarCandidato')));
          await tester.pumpAndSettle();
          await tester.pumpAndSettle(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          expect(find.text('Assigned Tests'), findsOneWidget);
        });
  });
}