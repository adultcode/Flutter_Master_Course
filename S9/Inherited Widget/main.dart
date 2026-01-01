import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'InheriState.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DBWidget()
    );
  }
}

class DBWidget extends StatefulWidget {
  const DBWidget({Key? key}) : super(key: key);

  @override
  _DBWidgetState createState() => _DBWidgetState();
}

class _DBWidgetState extends State<DBWidget> {

  int count = 0;
  void addCounter() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        child: MyInheritedWidget(
          count:count,
            addCounter:addCounter,
          child:Demo()
        ),
      )
    );
  }
}


class Demo extends StatelessWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counterState = MyInheritedWidget.of(context);
    return Container(
      child: Column(
        children: [
          Text("count: ${counterState.count}"),
          SizedBox(height: 50.0,),
          TextButton(onPressed: (){
            counterState.addCounter();
          }, child: Text("Add"))
        ],
      ),
    );
  }
}
