import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: const MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 // final _subscription = MyData.controller;

  late StreamController<int> _controller;
  late StreamSubscription<int> _subscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = MyData.controller;

     _subscription = _controller.stream.listen((event) {
      print("Data: $event");
    });
    // final StreamSubscription<int> _subscription = MyData.controller.stream.listen((event) {
    //   print("Data: $event");
    // });

  }
  @override
  Widget build(BuildContext context) {

  return Scaffold(
    appBar: AppBar(
      title: Text("Stream"),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         // Text("Data:"),
          StreamBuilder(
              stream: _controller.stream,
              initialData: 0,
              builder: (context, snapshot) {
             //   print("Connection state: ${snapshot.connectionState}");
              //  print("isClosed: ${_controller.isClosed}");
                if(!_controller.isClosed)
                  return Text("Data: ${snapshot.data}",style: TextStyle(fontSize: 20),);
                else return Text("Connection is Done",style: TextStyle(fontSize: 20),);
              },
          ),
          SizedBox(height: 30,),
          MyData(),
          SizedBox(height: 30,),
          ElevatedButton(
              onPressed: () {
                //_subscription.close();
                _subscription.pause();
              },
              child: Text("Pause")
          ),
          SizedBox(height: 30,),
          ElevatedButton(
              onPressed: () {
                //_subscription.close();
                _subscription.resume();
              },
              child: Text("Resume")
          ),
          SizedBox(height: 30,),
          ElevatedButton(
              onPressed: () {
                //_subscription.close();
                _subscription.cancel();
              },
              child: Text("Cancel")
          )
        ],
      ),
    ),
  );
  }
}


class MyData extends StatelessWidget {

  static StreamController<int> controller = StreamController<int>.broadcast();

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:() {

        //  if(!controller.isClosed){
            index++;
            controller.sink.add(index);
          //}


        },
        child: Text("Send data",style: TextStyle(fontSize: 18),)
    );
  }
}
