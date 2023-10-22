import 'package:abcjobs_movil/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Candidate register',
            (tester) async {
          // Load app widget.
          await tester.pumpWidget(const ABCJobsApp());
          
          await tester.pumpAndSettle();
          await tester.tap(find.byKey(const Key('_btnIrARegistrarCandidato')));
          await tester.pumpAndSettle();

          await tester.enterText(find.byKey(const Key('_nombres')), "Prueba Nombres");
          await tester.enterText(find.byKey(const Key('_apellidos')), "Prueba Apellidos");
          await tester.enterText(find.byKey(const Key('_tipoDocumento')), "1");
          await tester.enterText(find.byKey(const Key('_numDocumento')), "123456");
          await tester.enterText(find.byKey(const Key('_celular')), "3000000000");
          await tester.enterText(find.byKey(const Key('_email')), "prueba@prueba.com");
          await tester.enterText(find.byKey(const Key('_password')), "123456");

          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pumpAndSettle();
          await tester.tap(find.byKey(const Key('_btnRegistrarCandidato')));
          await tester.pumpAndSettle(const Duration(seconds: 4));
          await tester.tap(find.byKey(const Key('_btnIrALogin')));
          await tester.pumpAndSettle();


          /// Ahora hace login
          await tester.enterText(find.byKey(const Key('_email')), "prueba@prueba.com");
          await tester.enterText(find.byKey(const Key('_password')), "123456");
          await tester.pumpAndSettle();
          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pumpAndSettle();
          await tester.tap(find.byKey(const Key('_btnAutenticarCandidato')));
          await tester.pumpAndSettle();
          await tester.pumpAndSettle(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          expect(find.text('Successfully logged in'), findsOneWidget);
        });
  });
}