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


  appRoutes()=>[

    GetPage(
        name: '/page1',
        page: ()=> Page1(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500)
    ),
    GetPage(
        name: '/page2',
        page: ()=> Page2(),
        transition: Transition.circularReveal,
        transitionDuration: Duration(milliseconds: 500)
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
          title: 'Flutter Demo',
          initialBinding: MyBinding(),
          getPages: appRoutes(),
          initialRoute: '/page1',
          //home:  MyHomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   final my_controller  = Get.find<MyController>();
//
//   @override
//   Widget build(BuildContext context) {
//
//       return Scaffold(
//         appBar: AppBar(
//           title: Text("Getx"),
//         ),
//         body: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 15.0,vertical: 15.0),
//               child: TextField(
//                 controller: my_controller.myname_controller,
//                 decoration: InputDecoration(
//                   hintText: "Say your name.."
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.0,),
//             ElevatedButton(
//                 onPressed: (){
//                   my_controller.updateName( my_controller.myname_controller.text );
//                   print("Name: ${my_controller.my_name}");
//
//                   Get.snackbar('-Name-', 'New name: ${my_controller.my_name}',
//                   snackPosition: SnackPosition.BOTTOM);
//
//             },
//                 child: Text("Show name",style: TextStyle(fontSize: 25.0),))
//           ],
//         ),
//       );
//
//   }
// }



class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Page one",style: TextStyle(fontSize: 18.0),),
            SizedBox(height: 25.0,),
            ElevatedButton(
                onPressed: (){
                  Get.toNamed('/page2',arguments: 10);

                },
                child: Text("Go to page 2"))
          ],
        ),
      ),
    );
  }
}


class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.greenAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("Page two ${Get.arguments}",style: TextStyle(fontSize: 18.0),),
              SizedBox(height: 25.0,),
              ElevatedButton(onPressed: (){
                //Get.offNamed('/page1');
                Get.back();
              }, child: Text("Back to page 2"))
            ],
          ),
        ),
      ),
    );
  }
}
