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
          child: STFW()
        )
      ),
    );
  }
}

class STFW extends StatefulWidget {
  const STFW({Key? key}) : super(key: key);

  @override
  _STFWState createState() => _STFWState();
}

class _STFWState extends State<STFW> {

  var selected = 0;
  ChangeValue(int val){
    setState(() {
      print("Selcted $val");
      selected = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child:
      Column(

        children: [
          RadioListTile(
              value: 1,
              title: Text("Item 1"),
              groupValue: selected,
              onChanged: (value){
                setState(() {
                  ChangeValue(value as int) ;
                });
              }
          ),
          RadioListTile(
              value: 2,
              title: Text("Item 2"),
              groupValue: selected,
              activeColor: Colors.green,
              onChanged: (value){
                setState(() {
                  ChangeValue(value as int) ;
                });
              }
          ),
          RadioListTile(
              value: 3,
              title: Text("Item 3"),
              activeColor: Colors.red,
              groupValue: selected,
              onChanged: (value){
                setState(() {
                  ChangeValue(value as int) ;
                });
              }
          )
        ],
      )

    );
  }
}


/*
checkbox
 */
// CheckboxListTile(
// title: Text("Save.."),
// activeColor: Colors.green,
// checkColor: Colors.black,
// //shape: CircleBorder(),
// value: active,
// onChanged: (value){
// print("value: $value");
// setState(() {
// active = value!;
// });
// },
// ),
