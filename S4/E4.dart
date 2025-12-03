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
  var city =[];

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    city.add("Tehran");
    city.add("Tabriz");
    city.add("Shiraz");
    city.add("Kish");
    city.add("Rasht");
    city.add("Karaj");
    city.add("Qeshm");
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: city.length,
      itemBuilder: (context,index){
          return MyWidget(city[index], index%2);
      },

      // children: [
      //   MyWidget(" Item 1"),
      //   MyWidget(" Item 2"),
      //   MyWidget(" Item 3"),
      //   MyWidget(" Item 4"),
      //   MyWidget(" Item 5"),
      //   MyWidget(" Item 6"),
      //   MyWidget(" Item 7"),
      //   MyWidget(" Item 8"),
      // ],
    );
  }
}




class MyWidget extends StatelessWidget {

  var text;
  var index;


  MyWidget(this.text,this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: index==0?Colors.blue:Colors.red,
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),

      width: MediaQuery.of(context).size.width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}


class MyWidget2 extends StatelessWidget {

  var text;


  MyWidget2(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.blue,
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),

      width: MediaQuery.of(context).size.width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}

