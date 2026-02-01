import 'package:flutter/material.dart';
import 'package:untitled3/buy_btn.dart';
import 'package:untitled3/screen_size.dart';
import 'package:untitled3/watch_btn.dart';

import 'cast_item.dart';
import 'movie.dart';

class MovieInfo extends StatelessWidget {
  Movie _movie;

  MovieInfo(this._movie);

  var desc = "A robot who is responsible fois responsible for cleaning a waste-covered  Earth meets another robot and falls in love with her. Together, they set out on a journey that will alter the fate of mankind";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("7.3/10    |   Hollywood   |   English",style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.w300),),
          SizedBox(height: ScreenSize.height*3,),
          Text(_movie.name.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,
          fontSize: 45.0),),
          SizedBox(height: ScreenSize.height*5,),
          Container(
            width: ScreenSize.width*70,
            child: Text(desc,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),),
          ),
          Container(
            width: ScreenSize.width*50,
            margin: EdgeInsets.only(top: ScreenSize.height*7),
            child: Row(
              children: [

                WatchBtn(),
                SizedBox(width: 20.0,),
                BuyBtn()
              ],
            ),
          ),
          SizedBox(height: ScreenSize.height*13,),
          Text("Producers",style: TextStyle(fontSize: 20.0,color: Colors.white),),
          Container(
            height: ScreenSize.height*6,
            width: ScreenSize.width*70,
            margin: EdgeInsets.only(top: ScreenSize.height*2),
            child: ListView.builder(
              itemCount: _movie.cast?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CastItem(_movie.cast![index]);
              },
            ),
          )



        ],
      ),
    );
  }
}
