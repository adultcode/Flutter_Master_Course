import 'package:flutter/material.dart';
import 'package:untitled3/movie.dart';
import 'package:untitled3/screen_size.dart';

import '../buy_btn.dart';
import '../cast_item.dart';
import '../watch_btn.dart';

class SmallScreen extends StatelessWidget {
  Movie _movie;


  SmallScreen(this._movie);
  var desc = "A robot who is responsible fois responsible for cleaning a waste-covered  Earth meets another robot and falls in love with her. Together, they set out on a journey that will alter the fate of mankind";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.width*3),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              ),
              SizedBox(height: ScreenSize.height*2,),
              Text("7.3/10    |   Hollywood   |   English",style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w300),),
              SizedBox(height: ScreenSize.height*3,),
              Text(_movie.name.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,
                  fontSize: 35.0),),
              SizedBox(height: ScreenSize.height*4,),
              Container(
                width: ScreenSize.width*70,
                child: Text(desc,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),),
              ),
              SizedBox(height: ScreenSize.height*2,),
              WatchBtn(),
              SizedBox(height: 20.0,),
              BuyBtn(),
              SizedBox(height: ScreenSize.height*4,),
              Text("Producers",style: TextStyle(fontSize: 20.0,color: Colors.white),),
              Container(
              //  height: ScreenSize.height*6,
                width: ScreenSize.width*70,
                margin: EdgeInsets.only(top: ScreenSize.height*2),
                child: ListView.builder(
                  itemCount: _movie.cast?.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return CastItem(_movie.cast![index]);
                  },
                ),
              )

            ],
          )
        ],
      ),
    );
  }
}
