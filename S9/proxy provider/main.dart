import 'dart:async';

import 'package:course/manage.dart';
import 'package:course/school.dart';
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

      home:  MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) =>  School(3),),
          ChangeNotifierProvider(create: (context) =>  Student(10),),
          // proxy provider
          ProxyProvider2<School, Student,Manage>(
            create: (context) => Manage(
              classes: context.read<School>().classes_count,
              students: context.read<Student>().students_count,
            ),
            update: (context, school, student, manage) {
              return Manage(
                classes: school.classes_count,
                students: student.students_count,
              );
            },
          )

    ],
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
    // context.read<Student>().addListener(() {
    //   print("Read age:  ${context.read<Student>().age }");
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

          // Consumer<Student>(builder: (context, value, child) {
          //   return Text("Age: ${value.age}");
          // },),

      //    Text("Read age:  ${context.read<Student>().age }",style: TextStyle(fontSize: 20),),
          SizedBox(height: 30,),
          Consumer<Manage>(
            builder: (context, value, child) {
              final result = value.students! + value.classes!;

              return Text("Sum: $result", style: TextStyle(fontSize: 20));
            },
          ),
          Text("Status: ${context.watch<Manage>().Calcute()}",
          style: TextStyle(fontSize: 20),),
          SizedBox(height: 30,),




          ElevatedButton(
              onPressed: () {
                context.read<School>().AddClass();
              },
              child: Text("Add Class")
          ),

          SizedBox(height: 30,),
          ElevatedButton(
              onPressed: () {
                context.read<Student>().IncreaseStudent();
              },
              child: Text("Add Student")
          ),

        ],
      ),
    ),
  );
  }
}


