import 'dart:convert';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';




import 'animal_bloc.dart';
import 'animal_state.dart';

void main() async {
  runApp(MaterialApp(
      home: MyApp(),

  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  AssetsAudioPlayer? _assetsAudioPlayer;
 var resume = false;
 var stl = TextStyle(fontSize: 25.0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  _assetsAudioPlayer = AssetsAudioPlayer();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(

         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.play_circle_outline,size: 40.0,),
                onPressed: (){
                  if(resume){
                    _assetsAudioPlayer!.play();
                  }else{
                    _assetsAudioPlayer!.open(
                        Audio("assets/music/m80.mp3"),showNotification: true
                    );
                    resume = true;
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.pause_circle_outline_outlined,size: 40.0,),
                onPressed: (){
                _assetsAudioPlayer!.pause();
                },
              ),
              StreamBuilder(
                stream: _assetsAudioPlayer!.currentPosition,
                builder: (context,AsyncSnapshot<Duration> snap){
                  if(snap.hasData){
                    return Text("Time: ${snap.data!.inMinutes}:${snap.data!.inSeconds}",
                    style: stl,);
                  }else return Text("Not playing...");
                },
              ),
              StreamBuilder(
                stream: _assetsAudioPlayer!.current,
                builder: (context,AsyncSnapshot<Playing?> snap){
                  if(snap.hasData){
                    return Text('${snap.data!.audio.duration.inMinutes}:'
                        '${snap.data!.audio.duration.inSeconds%60}',style:stl);
                  }else return Text("nooo");
                },
              ),
              StreamBuilder(
                stream: _assetsAudioPlayer!.currentPosition,
                builder: (context,AsyncSnapshot<Duration> snap){
                  if(snap.hasData && _assetsAudioPlayer!.current.hasValue){
                    return Container(
                      width: 300.0,
                      child: Slider(
                        min:0.0,
                        max: _assetsAudioPlayer!.current.value!.audio.duration.inMilliseconds.toDouble(),
                        value: snap.data!.inMilliseconds.toDouble(),
                        onChanged: (val){},
                      ),
                    );
                  }else return Container();
                }
              )
            ],
          )
        )
    );
  }
}
