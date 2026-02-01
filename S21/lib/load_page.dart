import 'package:flutter/material.dart';
import 'package:untitled3/movie.dart';
import 'package:untitled3/responsive/big_screen.dart';
import 'package:untitled3/responsive/small_screen.dart';
import 'package:untitled3/screen_size.dart';

class LoadPage extends StatelessWidget {

  Movie _movie;
  var size;


  LoadPage(this._movie,this.size);

  Widget ShowScreen(){
    if(size>770) return BigScreen(_movie);
        else return SmallScreen(_movie);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Image.asset(_movie.wallpaper.toString(),
        height: ScreenSize.height*100,
          width: ScreenSize.width*100,
          fit: BoxFit.fill,
        ),
        Container(
          height: ScreenSize.height*100,
          width: ScreenSize.width*100,
          color: Colors.black.withOpacity(0.68),
        ),
        ShowScreen()

      ],
    );
  }
}
