import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      home:  MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final platform = MethodChannel("com.platform");

  var _sms = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    platform.setMethodCallHandler((call) async{
      if(call.method=="GetSMS"){

        GetSMS(call.arguments);
        return 0;

      }else{
        return MissingPluginException("not implemented");
      }
    },);
  }

  void GetSMS(String sms){

    setState(() {
      _sms = sms;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text("Start"),
        onPressed: () async{

         platform.invokeMethod("toast",{
           "name":"Flutter-learn.ir"
         });
        },
      ),
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text("Homepage: $_sms"),
        ),
      ),
    );
  }
}


