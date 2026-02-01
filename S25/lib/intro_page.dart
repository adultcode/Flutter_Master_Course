import 'package:flutter/material.dart';
import 'package:untitled/main.dart';

class IntroPage extends StatelessWidget {
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 15),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter your name'
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyWidget(controller.text),));
                  },
                  child: Text("Login to room"))
            ],
          ),


      ),
    );
  }
}
