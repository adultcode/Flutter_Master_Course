import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unit/util/myinput.dart';

main(){
  group('Sum numbers test', () {
    testWidgets('Test A and B', (widgetTester)async {
      await widgetTester.pumpWidget(MyInput());

      await widgetTester.enterText(find.byKey(Key('a_input')), '2');
      await widgetTester.enterText(find.byKey(Key('b_input')), '4');

      await widgetTester.tap(find.byKey(Key('btn_key')));

      await widgetTester.pump();

      expect(find.text('4'), findsOneWidget);

    });
  });
}