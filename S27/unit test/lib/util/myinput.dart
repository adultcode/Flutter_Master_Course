import 'package:flutter/material.dart';

class MyInput extends StatefulWidget {
  const MyInput({Key? key}) : super(key: key);

  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  var a_controller = TextEditingController();
  var b_controller = TextEditingController();
  var _value = 0;
  var a_key = Key("a_input");
  var b_key = Key("b_input");
  var btn_key = Key("btn_key");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text(_value.toString()),
             Text('6'),
            TextField(
              key: a_key,
              controller: a_controller,
            ),
            TextField(
              key: b_key,
              controller: b_controller,
            ),
            ElevatedButton(
              key: btn_key,
                onPressed: (){
                  setState(() {
                    _value = int.parse(a_controller.text)+  int.parse(b_controller.text);
                  });
                },
                child: Text("Click me"))
          ],

        ),

      ),
    );
  }
}
