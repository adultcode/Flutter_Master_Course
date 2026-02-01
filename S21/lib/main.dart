
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:image_network/image_network.dart';
import 'package:untitled3/movie_repository.dart';
import 'package:untitled3/screen_size.dart';

import 'load_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAooState();
}

class _MyAooState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScroll(),
      home: MyWidget(),
    );
  }
}

class MyCustomScroll extends MaterialScrollBehavior{
  @override
  Set<PointerDeviceKind> get dragDevices=>{
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse
  };
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>  with SingleTickerProviderStateMixin{

  var page = 0;
  var prev = 0;
  late Animation<Offset> _first_anim,_sec_anim;
  late AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MovieRepository.InitList();

    _animationController = AnimationController(vsync: this,
    duration: Duration(milliseconds: 500)
    );
    _first_anim =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-0.0, 0.0))
            .animate( _animationController);

    _sec_anim =
        Tween<Offset>(begin: const Offset(1500, 0), end: const Offset(0.0, 0.0))
            .animate( _animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context , constraints) {
          ScreenSize.height = constraints.maxHeight/100;
          ScreenSize.width = constraints.maxWidth/100;
          return Stack(
            children: [


              //LoadPage(MovieRepository.movie_list[0],constraints.maxWidth),
            AnimatedBuilder(
                animation: _first_anim,
                child: LoadPage(MovieRepository.movie_list[prev],constraints.maxWidth),
                builder: (context, child) {
                  return Transform.translate(offset:_first_anim.value,child: child,);

                }),
              AnimatedBuilder(
                  animation: _first_anim,
                  child: LoadPage(MovieRepository.movie_list[page],constraints.maxWidth),
                  builder: (context, child) {
                    return Transform.translate(offset:_sec_anim.value,child: child,);

                  }),

              Positioned(
                  bottom: 0.0,
                  child: Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                alignment: Alignment.center,
                width: ScreenSize.width*100,
                 child: InkWell(
                   child: Icon(Icons.arrow_right_alt,size: 30,color: Colors.redAccent,),
                   onTap: (){
                     _animationController.reset();
                     _animationController.forward();
                        setState(() {
                          prev = page;
                          if(page==2){
                            page = 0;
                          }else{
                            page++;
                          }
                        });
                   },
                 ),
              )
              )
            ],
          );
        },
      )
    );
  }
}


