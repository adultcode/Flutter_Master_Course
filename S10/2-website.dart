import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final counterProvider = StateProvider.autoDispose((ref)=>0);

void main(){
  runApp(
      ProviderScope(child: MaterialApp(
        home: MyApp(),
      ))
  );
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var _mydata = "";
  void SendRequest() async{

    // get, post, delete, put,
    var url = "http://flutter-learn.ir/app/website.json";
    try{
      var response = await Dio().get(url);

      print("website: ${response.data["website"]}");
      print("topic: ${response.data["topic"]}");
      setState(() {
        _mydata+= response.data["website"] ;
        _mydata += " - ";
        _mydata += response.data["topic"];
      });



    } catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Webservice"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){

          SendRequest();
        },
      ),
      body: Center(
        child: Text(_mydata,style: TextStyle(fontSize: 20.0),),
      )
    );
  }
}







