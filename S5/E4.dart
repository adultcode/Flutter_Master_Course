import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        body: SafeArea(
          child: STFW()
        )
      ),
    );
  }
}

class STFW extends StatefulWidget {
  const STFW({Key? key}) : super(key: key);

  @override
  _STFWState createState() => _STFWState();
}

class _STFWState extends State<STFW> {

  var controller = TextEditingController();
    @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.black12
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              style: TextStyle(fontSize: 20.0,color: Colors.cyan),
              controller: controller,
              obscureText: true,
             // maxLength: 5,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
               // prefixText: "Test",
               // prefixIcon: Icon(Icons.ac_unit),
                //suffixIcon: Icon(Icons.ac_unit),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: "Enter your name",
                hintStyle: TextStyle(fontSize: 20.0),
            //    border: OutlineInputBorder()
              ),
            )),



        SizedBox(height: 40.0,),
        ElevatedButton(onPressed: (){
          var text = controller.text;
          print("Text: $text");
        }, child: Text("Show Text"))
      ],
    );
  }
}
