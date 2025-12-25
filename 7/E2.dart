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
      initialRoute: "/",
      routes: {
        '/' : (context)=> Page1(),
        '/page2': (context) => Page2()
      },
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

                    Navigator.of(context).pushNamed('/page2',
                        arguments: MyArgs('Hesam', 2));

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


  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as MyArgs;

    return Material(
      child: SafeArea(
        child: Container(
          color: Colors.tealAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Page 2, ${args.name} - ${args.age}",style: TextStyle(fontSize: 30.0),),
              ElevatedButton(
                  onPressed: (){
                    //Navigator.of(context).pop();
                    Navigator.pop(context);
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

class MyArgs{
  var name;
  var age;

  MyArgs(this.name, this.age);
}