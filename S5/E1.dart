import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        body: SafeArea(
          child: MyWidget()
        )
      ),
    );
  }
}


class MyWidget extends StatelessWidget {

  var my_style = TextStyle(fontSize: 30.0,color: Colors.red,fontWeight: FontWeight.w600,
      fontStyle: FontStyle.italic);
  var my_style2 = TextStyle(fontSize: 30.0,color: Colors.blue,fontWeight: FontWeight.w600,
      );
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(
        text: 'Hello',
        style: TextStyle(fontSize: 20.0),
        children: <TextSpan>[
          TextSpan(text: 'Flutter-',style: my_style),
          TextSpan(text: 'Learn.ir',style: my_style2)
        ]
      ))
    );
  }
}



