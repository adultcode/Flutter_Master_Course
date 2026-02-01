import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:grpc/grpc.dart';
import 'package:grpc_example/proto/user.pb.dart';
import 'package:grpc_example/proto/user.pbgrpc.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student gRPC Client',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StudentClientPage(),
    );
  }
}

class StudentClientPage extends StatefulWidget {
  const StudentClientPage({super.key});

  @override
  State<StudentClientPage> createState() => _StudentClientPageState();
}

class _StudentClientPageState extends State<StudentClientPage> {


  var result = "";

 late ClientChannel _channel;

 Future<void> _userStream()async{
   debugPrint("---- _userStream");
   try {

     final client = StudentsClient(_channel);
     final request = StreamUsersRequest();

     final response = await client.streamUsers(request);

     response.listen((value) {
       debugPrint('''
        ID: ${value.user.id}, 
        name: ${value.user.name}, 
        email: ${value.user.email}\n
        ----------
        ''');
     },);
     debugPrint("Response: ${response.toString()}");


   }catch(e){
     setState(() {
       result = "Error";
     });
   }

 }
  Future<void> _fetchUser()async{

    debugPrint("---- _fetchUser");
    try {

      final client = StudentsClient(_channel);
      final req = GetUserRequest(id: 5);

      final response = await client.getUser(req);
      debugPrint("Response: ${response.toString()}");
      setState(() {
        result = '''
        ID: ${response.user.id}\n
        name: ${response.user.name}\n
        email: ${response.user.email}\n
        ''';
      });

    }catch(e){
      setState(() {
        result = "Error";
      });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _channel = grpc.ClientChannel(
        "10.0.2.2",
        port: 8000,
        options: const grpc.ChannelOptions(
            credentials: grpc.ChannelCredentials.insecure()
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 40,
          children: [

            Text("Response: ${result}"),
            ElevatedButton(onPressed: () {
              _userStream();
          //    _fetchUser();
            }, child: Text("Call grpc"))
          ],
        ),
      ),
    );
  }
}