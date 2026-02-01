import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unit/util/mytext.dart';
main(){
  group('Widget test group',() {

    testWidgets('Text widget count test', (widgetTester) async{
      await widgetTester.pumpWidget(MyText());
     // expect(find.byType(Text), findsNWidgets(3));
      expect(find.text('1'), findsNWidgets(3));

    });
    testWidgets('Setstate test widget', (widgetTester) async{
      await widgetTester.pumpWidget(MyText());
      // expect(find.byType(Text), findsNWidgets(3));
      await widgetTester.tap(find.byIcon(Icons.add));

      await widgetTester.pump();
      expect(find.text('5'), findsNWidgets(3));

    });
  },);
}