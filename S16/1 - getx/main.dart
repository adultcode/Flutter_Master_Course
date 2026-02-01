import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neww/my_binding.dart';
import 'package:neww/my_controller.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
          title: 'Flutter Demo',
          initialBinding: MyBinding(),
          home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final my_controller  = Get.find<MyController>();

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          title: Text("Getx"),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 15.0),
              child: TextField(
                controller: my_controller.myname_controller,
                decoration: InputDecoration(
                  hintText: "Say your name.."
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
                onPressed: (){
                  my_controller.updateName( my_controller.myname_controller.text );
                  print("Name: ${my_controller.my_name}");

                  Get.snackbar('-Name-', 'New name: ${my_controller.my_name}',
                  snackPosition: SnackPosition.BOTTOM);

            },
                child: Text("Show name",style: TextStyle(fontSize: 25.0),))
          ],
        ),
      );

  }
}
