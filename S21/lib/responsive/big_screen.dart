import 'package:flutter/material.dart';
import 'package:untitled3/movie.dart';

import '../movie_info.dart';
import '../screen_size.dart';

class BigScreen extends StatelessWidget {

  Movie _movie;

  BigScreen(this._movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: ScreenSize.height*3,horizontal: ScreenSize.width*5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/logo.png',height: 40,width: 80,),
                Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: ScreenSize.height*3,horizontal: ScreenSize.width*5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MovieInfo(_movie),
                Container(

                  width: (ScreenSize.width+ScreenSize.height)*10,
                  height: (ScreenSize.width+ScreenSize.height)*15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white
                    ),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(_movie.poster.toString())
                    )
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
