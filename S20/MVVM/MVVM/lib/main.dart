import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:neww/api_response.dart';
import 'package:neww/post_model.dart';
import 'package:neww/viewmodel/viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PostViewModel())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',

          home:  MyHomePage(),

      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  PostViewModel? viewModel;

  @override
  void initState() {
    // TODO: implement initState
    viewModel = Provider.of<PostViewModel>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel?.GetData();
      print("callback");
    });
  }

  Widget PostList(ApiResponse _apires){
    if(_apires.status==200){
      return ListView.builder(
        itemCount: _apires.data.length,
        itemBuilder: (ctx,index){
          return Container(
            margin: EdgeInsets.symmetric(vertical: 15.0),
            child: Text(_apires.data[index].content.toString()),
          );
        },
      );
    }else{
      return Text(_apires.data.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: Text("MVVM"),
      ),
      body: Center(
          child: PostList(viewModel!.response),
      )
    );
  }
}
