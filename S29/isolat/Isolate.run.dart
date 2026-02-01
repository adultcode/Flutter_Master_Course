import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isolatee/todo.dart';

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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  AnimatedContainer(),
    );
  }
}



class AnimatedContainer extends StatefulWidget {
  @override
  _AnimatedContainerState createState() => _AnimatedContainerState();
}

class _AnimatedContainerState extends State<AnimatedContainer> with SingleTickerProviderStateMixin  {

  late AnimationController _controller;
  late Animation<Offset> _animation;
  //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(seconds: 2));
    _animation = Tween<Offset>(begin: Offset.zero,end: Offset(6,0)).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideTransition(position: _animation,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.redAccent,
              ),),
              SizedBox(height: 40,),
              ElevatedButton(onPressed: ()async{
                try{
                  //var result = await Isolate.run(TestTask);
                  var result = await compute(TestTask,1);
                  print("Isolate result: $result");
                }catch(e){
                  print("error: ${e.toString()}");
                }
              },
                  child: Text("Run Task")),

            ],
          ),

        ),
      ),
    );
  }


}

void GetData(SendPort port)async{


  var url = 'https://jsonplaceholder.typicode.com/todos/';
  port.send('request started');

  Response response = await Dio().get(url);

  Iterable iterable = response.data;
  List<Todo> mylist = iterable.map((e) => Todo.fromJson(e)).toList();

  port.send(mylist);
}



Future<int> TestTask(int a)async{
  // sendPort.send('-------------- New Isolate---------');
  print(Isolate.current.debugName.toString());
  var result = 0;
  for(int i = 0; i<1450000000;i++){
    result++;

    // if(result==50000){
    //   throw Exception("Fake exception");
    // }
  }

  // sendPort.send('Result: $result -------------');
  return result;

}