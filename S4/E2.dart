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
        body: Center(
          child: Container(
            width: 100.0,
            height: 100.0,

           // margin: EdgeInsets.all(80.0),
            padding: EdgeInsets.only(left: 30.0,top: 30.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end:   Alignment.bottomRight,
                  colors: [Colors.lightBlueAccent,Colors.greenAccent]
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
              // border: Border.all(width: 3.0,color: Colors.blue)
            ),
            child: Text("Hello world"),
          ),
        )
      ),
    );
  }
}

