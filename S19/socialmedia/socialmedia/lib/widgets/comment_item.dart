import 'package:flutter/material.dart';
import 'package:socialmedia/model/comment_model.dart';
import 'package:socialmedia/util/my_color.dart';
import 'package:socialmedia/util/screen_size.dart';

import '../util/myURL.dart';

class CommentItem extends StatelessWidget {
  CommentModel cm;


  CommentItem(this.cm);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width*4,vertical: ScreenSize.height),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: ScreenSize.width*10,
            height: ScreenSize.width*10,
            margin: EdgeInsets.only(right: ScreenSize.width*1.5),
            decoration: BoxDecoration(

                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage("${Urls.media}${cm.user_set!.avatar}")
                )
            ),

          ),
          SizedBox(width: 10.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cm.user_set!.name.toString(),style: TextStyle(
                  color: MyColor.title_black,fontWeight: FontWeight.w600
                ),),
                SizedBox(height: 5.0,),
                Text(cm.content.toString(), style: TextStyle(color: MyColor.input_border),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
