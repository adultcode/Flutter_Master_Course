import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:unit/util/text_generate.dart';
main(){

  //setUp(() => print("This is unit test"));
  test('Sum numbers',() async{

    expect(await TextGenerate.SumNumbs(1, 2),2);
  },);
  test('Check name test',() {
    final result2 = TextGenerate.SayHi(name: null);
    
    expect(result2,'Hi f');
  },);
  // group('Text generation group', () {
  //   test('Text generating Low', () {
  //
  //     var _num = 3;
  //
  //     var _result = TextGenerate.PrintText(_num);
  //
  //     expect(_result, 'Low');
  //
  //   });
  //
  //   test('Text generating High', () {
  //
  //     var _num = 12;
  //
  //     var _result = TextGenerate.PrintText(_num);
  //
  //     expect(_result, 'High');
  //
  //   });
  // });

}