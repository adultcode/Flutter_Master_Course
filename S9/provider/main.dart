import 'dart:async';

import 'package:course/student.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

      home: ChangeNotifierProvider(

        create: (context) => Student("Hesam", 10),
        child: const MyHomePage(),
      ),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Student>().addListener(() {
      print("Read age:  ${context.read<Student>().age }");
    });
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

          // Consumer<Student>(builder: (context, value, child) {
          //   return Text("Age: ${value.age}");
          // },),

          Text("Read age:  ${context.read<Student>().age }",style: TextStyle(fontSize: 20),),
          SizedBox(height: 30,),
        //  Text("Watch age:  ${context.watch<Student>().age }",style: TextStyle(fontSize: 20),),
          SizedBox(height: 30,),
          Text("Select age:  ${context.select<Student,int>((value) => value.age) }",style: TextStyle(fontSize: 20),),
          SizedBox(height: 30,),




          ElevatedButton(
              onPressed: () {
                Provider.of<Student>(context,listen: false).IncreaseAge('New Hesam');
              },
              child: Text("Pause")
          ),

        ],
      ),
    ),
  );
  }
}


