import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webview_flutter/webview_flutter.dart';



class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String current_url = "https://soft98.ir/";
  WebViewController? controller;
  var text_controller = TextEditingController();
  List<String> _urls = [];
  @override
  void initState() {
    _urls.clear();
    _urls.add(current_url);
    text_controller.text = current_url;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)

    ..setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (request) {
          print("--------- on request------");
          current_url = request.url;
          _urls.add(current_url);
          text_controller.text = current_url;
          return NavigationDecision.navigate;
        },
      )
    )
    ;

    controller?.loadRequest(Uri.parse(current_url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            onSubmitted: (value) {
              print("Clickedddd.....");
              current_url = value;
              _urls.add(current_url);
              controller?.loadRequest(Uri.parse(current_url));
            },
            controller: text_controller,
            decoration: InputDecoration(
                hintText: 'Enter link',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none),
          ),
          leading: IconButton(
            onPressed: (){

              print("---Back button clicked----");
              _urls.removeLast();
              current_url = _urls.last;
              text_controller.text = current_url;
              controller?.loadRequest(Uri.parse(current_url));
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          child: WebViewWidget(
            controller: controller!,
          ),
        ));
  }
}

