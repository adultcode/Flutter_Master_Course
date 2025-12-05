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
    return Center(
      child:
        InkWell(
          onTap: (){
            print("Inkwell clicked...");
          },
          child: Container(
            
            decoration: BoxDecoration(
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.circular(45.0)
            ),
            padding: EdgeInsets.symmetric(vertical: 30.0,horizontal: 55.0),
            child: Text("Click me...",style: TextStyle(color: Colors.white,
            fontSize: 30.0,fontWeight: FontWeight.bold),),
          ),
        )

      // TextButton(
      //   onPressed: (){
      //     print("Text clicked....");
      //   },
      //   child: Text("Click Text..",style: TextStyle(fontSize: 30.0),),
      // )



      // ElevatedButton(
      //   style: ElevatedButton.styleFrom(
      //     primary: Colors.green,
      //     elevation: 10.0,
      //     padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 25.0),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(30.0)
      //     )
      //   ),
      //   child: Text("Click me..",style: TextStyle(fontSize: 30.0),),
      //   onPressed: (){
      //     print("Button clicked....");
      //   },
      // )
    );
  }
}



