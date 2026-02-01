import 'package:flutter/material.dart';
import 'package:unit/widget/destination_page.dart';
class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  TextEditingController name_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  var form_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Welcome"),
          SizedBox(height: 30,),
          Form(
            key:form_key,
            child: Column(
              children: [
                TextFormField(
                  decoration:  InputDecoration(hintText: 'Name'),
                  controller: name_controller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    return value!.isNotEmpty?null:'Name is empty';
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  decoration:  InputDecoration(hintText: 'Name'),
                  controller: password_controller,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    return value!.isNotEmpty?null:'Password is empty';
                  },
                ),
                SizedBox(height: 15,),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DestinationPage(name_controller.text),));
                },
                    child: Text("Sign in"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
