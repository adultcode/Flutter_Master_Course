import 'package:flutter/material.dart';

class MyText extends StatefulWidget {
  const MyText({Key? key}) : super(key: key);

  @override
  State<MyText> createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  var value = '1';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text(value),
            Text(value),
            Text(value),
            IconButton(onPressed: (){
              setState(() {
                value = '2';
              });
            }
                , icon: Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
