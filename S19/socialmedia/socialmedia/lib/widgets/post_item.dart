import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:socialmedia/bloc/likepost_cubit.dart';
import 'package:socialmedia/model/post_model.dart';
import 'package:socialmedia/state/likepost_state.dart';
import 'package:socialmedia/util/myURL.dart';
import 'package:socialmedia/util/my_color.dart';
import 'package:socialmedia/util/screen_size.dart';


class PostItem extends StatefulWidget {
  PostModel postModel;
  PostItem(this.postModel);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {

  var _initIcon;
  var liked = 0;
  LikePostCubit? _cubit;
  @override
  void initState() {
    // TODO: implement initState
      _cubit = LikePostCubit();
    if(widget.postModel.is_liked==true){
      liked = 1;
      _initIcon = Icon(Icons.favorite,color: Colors.red,);
    }else{
      _initIcon = Icon(Icons.favorite_border);
    }
  }


  Widget MyIcon(Icon _icon){
    return IconButton(onPressed: (){
      var _data = {
        "postid": widget.postModel.id
      };
      _cubit?.SendRequest(_data);
    },
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        constraints: BoxConstraints(),
        icon: _icon,
      alignment: Alignment.center,
    );
  }

  Widget ShowImage(){

    if(widget.postModel.image!=null){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: ScreenSize.width),
        width: ScreenSize.width*100,
        height: ScreenSize.width*60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0,1),
              blurRadius: 5,
              color: Colors.black.withOpacity(0.3)
            )
          ],
          image: DecorationImage(
            image: NetworkImage(widget.postModel.image.toString()),
            fit: BoxFit.fill
          )
        ),
      );
    }else{
      return Container();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.width*100,
      margin: EdgeInsets.only(top: 10.0,bottom: 5.0),
      padding: EdgeInsets.only(right: ScreenSize.width*3,left: ScreenSize.width*3,
                    top: ScreenSize.width*2,
      bottom: ScreenSize.width*0.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(widget.postModel.user_set!.name.toString(),
                style: TextStyle(color: MyColor.title_black,fontWeight: FontWeight.w600),),
              ),
              InkWell(
                onTap: (){
                  context.pushNamed('profile',extra: widget.postModel.user_set);
                },
                child: Container(
                  width: ScreenSize.width*13,
                  height: ScreenSize.width*13,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0,1),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.3)
                        )
                      ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(Urls.media+widget.postModel.user_set!.avatar.toString())
                    )
                  ),

                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenSize.width,vertical: ScreenSize.width*2),
            width: ScreenSize.width*100,
            child: Text(widget.postModel.content!,style: TextStyle(fontSize: 15.0,color: MyColor.title_black),
            maxLines: 1,textAlign: TextAlign.right,),
          ),
          ShowImage(),
          SizedBox(height: 15.0,),
          Row(
            children: [

              BlocBuilder<LikePostCubit,LikePostState>(
                bloc: _cubit,
                builder: (context,state){
                  if(state is LikedState){
                    return MyIcon(Icon(Icons.favorite,color: Colors.red,));
                  }else if(state is UnLikedState){
                    return MyIcon(Icon(Icons.favorite_border));
                  }else{
                    return IconButton(onPressed: (){
                      var _data = {
                        "postid": widget.postModel.id
                      };
                      _cubit?.SendRequest(_data);
                    },
                      icon: _initIcon,alignment: Alignment.center,);

                }
                },
              ),




              Text(widget.postModel.like_count.toString(),textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0,color: MyColor.title_black,
                fontWeight: FontWeight.w600),),

              SizedBox(width: 30.0,),
              IconButton(onPressed: (){
                context.pushNamed('postpage',extra: widget.postModel);
              },
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  constraints: BoxConstraints(),

                  icon: Icon(Icons.messenger_outline)),
              Text(widget.postModel.comment_count.toString(),textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0,color: MyColor.title_black,
                    fontWeight: FontWeight.w600),),

            ],
          )
        ],
      ),
    );
  }
}
