import 'package:flutter/material.dart';
import 'package:unit/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
void main(){
  group(
    'App Integration test',() {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

      testWidgets('Full test', (widgetTester) async{

        app.main();

        await widgetTester.pumpAndSettle();

        final nameFormfield = find.byType(TextFormField).first;
        final passwordFormfield = find.byType(TextFormField).last;
        final signinbtn = find.byType(ElevatedButton);

        await widgetTester.enterText(nameFormfield, 'Hesam');
        await widgetTester.enterText(passwordFormfield, '123');

        await widgetTester.pumpAndSettle();
        await widgetTester.tap(signinbtn);
        await widgetTester.pumpAndSettle();





      });


    },
  );
}