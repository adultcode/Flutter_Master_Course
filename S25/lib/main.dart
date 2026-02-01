import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:untitled/chat_item.dart';
import 'package:untitled/intro_page.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'chat_model.dart';





void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',


      home: MyWidget('hesam')
     // home: IntroPage()
    );
  }
}

class MyWidget extends StatefulWidget {
  var name;

  MyWidget(this.name);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>  {


  var channel = WebSocketChannel.connect(Uri.parse('ws://10.0.2.2:8002/ws/socket-server/'));
  var _controller = TextEditingController();
  List<ChatModel> my_list = [];
  @override
  void initState() {
    // TODO: implement initState

    channel.stream.listen((message) {
      print(message);
      var temp = jsonDecode(message);
      var name = temp['name'];
      var msg = temp['message'];
      setState(() {
        my_list.add(ChatModel(name, msg));
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chatroom"),
          ),

        body: ListView(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height*0.8,
              child: ListView.builder(
                itemCount: my_list.length,
                itemBuilder: (context, index) {
                  return ChatItem(my_list[index]);
                },
              ),
            ),
            Container(
              color: Colors.grey.withOpacity(0.1),
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [

                  Expanded(child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: " Type...."
                      ),
                    ),
                  )
                  ),

                  IconButton(
                      onPressed: (){
                        var text = _controller.text;
                        channel.sink.add(
                          jsonEncode(
                            {
                              'message':text,
                              'name':widget.name
                            }
                          )
                        );
                        _controller.clear();
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            )
          ],
        )
    );
  }
}
