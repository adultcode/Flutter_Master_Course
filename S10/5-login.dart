import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:season/madrid.dart';



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
  int a = 1;
  //var url = "http://flutter-learn.ir/app/x3.php?number=";
  var url = "http://flutter-learn.ir/app/login.php";

  void SendRequest(var number) async{

    // get, post, delete, put,
    print("${url}$number");
    print("a: $a");

    try{

      var response = await Dio().get("${url}$number");
      print(response.toString());


    } catch(e){
      print(e.toString());
    }
    print("---------------");
  }
  void LoginUser(var user,var passwpord) async{

    // get, post, delete, put,

  print("user: $user");
    try{

      var my_user = {
        "user": user.toString(),
        "password": passwpord.toString()
      };

      var form = FormData.fromMap(my_user);
      print("try");
      var response = await Dio().post(url,data:form );
      print(response.toString());
      setState(() {
        var temp = json.decode(response.data);
        status = temp['status'];
      });

    } catch(e){
      print(e.toString());
    }
    print("---------------");
  }
  // Future<List?> getMadrid() async {
  //   try {
  //     var response = await Dio().get(_madrid_url);
  //     print(response.data);
  //     Iterable userdata = response.data;
  //     List<Madrid> newlist = userdata.map((e) => Madrid.fromJson(e)).toList();
  //     return newlist;
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

    Widget UserItem(List<dynamic> userlist){
      var _style = TextStyle(fontSize: 18.0);

      return ListView.builder(

        itemCount: userlist.length,
        itemBuilder: (context,index){
          return Container(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 13.0,vertical: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(userlist[index].number!, style: _style,),
                    SizedBox(width: 10.0,),
                    Text(userlist[index].name!, style: _style,),
                  ],
                ),
                SizedBox(height: 6.0,),
                Text(userlist[index].position!, style: _style,),
              ],
            ),
          );
        },

      );
    }

  var user_controll = TextEditingController();
  var pass_controll = TextEditingController();
  var status = "empty";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Webservice"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){

         SendRequest(a);
         a++;
        },
      ),
      body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: user_controll,
                    decoration: InputDecoration(
                      hintText: 'Username...'
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: TextField(
                    obscureText: true,
                    controller: pass_controll,
                    decoration: InputDecoration(

                        hintText: 'Password...'
                    ),
                  ),
                ),
                ElevatedButton(
                    child: Text("Login"),
                    onPressed: (){
                      LoginUser(user_controll.text, pass_controll.text.toString());
                    },
                  ),
                Text("status: $status",style: TextStyle(fontSize: 20.0),)

              ],
            ),
      )
    );
  }
}







