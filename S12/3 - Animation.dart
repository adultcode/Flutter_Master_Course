import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'package:myapp/notification_controller.dart';



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


      home: MyWidget(),
      //home:  MyHomePage(),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation _profileAnimation;
  late Animation _helloAnimation;
  late Animation _listAnimation;

  @override
  void initState() {

    _controller = AnimationController(vsync: this,duration: Duration(seconds: 4));

    _profileAnimation = Tween(begin: 0.0,end: 45.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0,0.2,curve: Curves.easeIn)));

    _helloAnimation = Tween(begin: 0.0,end: 35.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.2,0.5,curve: Curves.easeInQuad)));


    _listAnimation = Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: _controller,
        curve: Interval(0.6,1.0,curve: Curves.easeOut)));

    _controller.forward();
    _controller.addListener(() {
      // setState(() {
      //
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [
          AnimatedBuilder(animation: _controller,
            builder: (context, child) => Icon(Icons.access_alarm_outlined,
            size: _profileAnimation.value,),)
        ],
      ),

      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 18.0),
                child: Text(" Hello world",
                  style: TextStyle(fontSize: _helloAnimation.value,fontWeight: FontWeight.w600),),
              ),
              Expanded(child: Transform.scale(
                scale: _listAnimation.value,
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0,horizontal: 5.0),
                      child: Text("Item #$index"),
                    );
                  },

                ),
              ))
            ],
          );
        },
      )

    );
  }
}
