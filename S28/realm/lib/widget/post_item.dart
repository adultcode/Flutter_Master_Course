import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realm_todo/model/post_model.dart';
import 'package:realm_todo/provider/post_provider.dart';

class PostItem extends StatelessWidget {


  PostModel postModel;

  PostItem(this.postModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*
          title and delete icon
           */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(postModel.title!,style: TextStyle(fontWeight: FontWeight.w500,
              color: Colors.white,fontSize: 18,),),
              IconButton(onPressed: () {
                /*
                delete post
                 */
                Provider.of<PostProvider>(context,listen: false).DeletePost(postModel);
              }, icon: Icon(Icons.remove_circle_outline_sharp,size: 18,
                  color: Colors.redAccent,))
            ],
          ),
          SizedBox(height: 6,),
          /*
          category and date
           */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(postModel.date!,style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,fontWeight: FontWeight.w300),),
              Text(postModel.category!,style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,fontWeight: FontWeight.w300),),
            ],
          ),
          SizedBox(height: 12,),
          Text(postModel.content!,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,
            fontSize: 18,),),


        ],
      ),
    );
  }
}
