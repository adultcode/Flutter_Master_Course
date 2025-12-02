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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.yellow,
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100.0,
            height: 100,
            color: Colors.redAccent,
          //  margin: EdgeInsets.only(bottom: 50.0),
          ),
         // SizedBox(height: 20.0,),
          Container(
            width: 100.0,
            height: 100.0,
            color: Colors.greenAccent,
          ),
          Container(
            width: 100.0,
            height: 100.0,
            color: Colors.lightBlueAccent,
          )
        ],
      ),
    );
  }
}



