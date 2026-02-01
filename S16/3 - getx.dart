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
          home:  _MyHomePageState(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

class _MyHomePageState extends GetView<MyController> {

  //final my_controller  = Get.find<MyController>();

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
                controller: controller.myname_controller,
                decoration: InputDecoration(
                  hintText: "Say your name.."
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
                onPressed: (){
                  controller.updateName( controller.myname_controller.text );
                  print("Name: ${controller.my_name}");

                  // Get.snackbar('-Name-', 'New name: ${controller.my_name}',
                  // snackPosition: SnackPosition.BOTTOM);


                  // Get.defaultDialog(
                  //   radius: 13.0,
                  //   contentPadding: EdgeInsets.all(15.0),
                  //   title: 'Getx',
                  //   middleText: 'this is middle',
                  //   textConfirm: 'Ok',
                  //   backgroundColor: Colors.red,
                  //   titleStyle: TextStyle(color: Colors.amberAccent),
                  //   confirm: ElevatedButton(onPressed: (){
                  //     Get.back();
                  //   },
                  //       child: Text("OK")
                  //   ),
                  //   cancel: OutlinedButton.icon(onPressed: (){},
                  //       icon: Icon(Icons.access_alarm_outlined),
                  //       label: Text("Cancel")
                  //   )
                  // );


                  Get.bottomSheet(
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                      ),
                      height: 200.0,

                      child: Center(child: Text("This is test ....",style: TextStyle(fontSize: 23.0,color: Colors.white))),
                    )
                  );



            },
                child: Text("Show name",style: TextStyle(fontSize: 25.0),)),

           // Obx(() => Text("Name: ${controller.my_name.value}"))
           //  GetX<MyController>(
           //    builder: (ctrl){
           //      return Text("Name2: ${ctrl.my_name.value}");
           //    },
           //  )

            GetBuilder<MyController>(builder:(ctrl){

              return Text("Name3: ${ctrl.my_name}");
            })

          ],
        ),
      );

  }
}
