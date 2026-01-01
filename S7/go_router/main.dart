import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/app_route.dart';

// Define route names for type safety

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});



  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      routerConfig: app_route,
    );
  }
}


class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First page"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          children: [
            Text("THis is Home page",style: TextStyle(fontSize: 25),),

            ElevatedButton(onPressed: () {
             context.push("/detail/hesam/?age=444",);
          //   context.push("/detail/test",);
             // context.pushNamed("detail");
          //    context.goNamed("detail");
            }, child: Text("Go to detail"))
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String message;
  const SecondScreen({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second page"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child:Column(
          children: [
            Text("THis is detail page \n $message",style: TextStyle(fontSize: 25),),

            ElevatedButton(onPressed: () {

              context.pop();
            }, child: Text("Back to home"))
          ],
        ),
      ),
    );
  }
}

