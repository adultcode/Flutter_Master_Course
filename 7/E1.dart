import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Page1(),
      ),
    );
  }
}


class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Text("Page 1",style: TextStyle(fontSize: 30.0),),
              ElevatedButton(
                  onPressed: (){

                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>  Page2("Hi"))
                    );

                  },
                  child: Text("Go to page2"))
            ],
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  var name;


  Page2(this.name);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: Colors.tealAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Page 2, $name",style: TextStyle(fontSize: 30.0),),
              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context)=> const Page1())
                    // );
                  },
                  child: Text("Back home"))
            ],
          ),
        ),
      ),
    );
  }
}
