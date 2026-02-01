import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socialmedia/model/user_model.dart';
import 'package:socialmedia/repository/follow_repository.dart';
import 'package:socialmedia/util/my_color.dart';
import 'package:socialmedia/util/screen_size.dart';
import 'package:socialmedia/util/user_instance.dart';

import '../util/myURL.dart';

class ProfileInfo extends StatefulWidget {
  UserModel userModel;

  ProfileInfo(this.userModel);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  var data;

  FollowRepository? _followRepository;
  @override
  void initState() {
    // TODO: implement initState
    _followRepository = FollowRepository();
    FollowRepository.streamController.stream.listen((event) {
      print("data: $event");
    });
  }
  Widget EditProfile(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColor.input_border
      ),
        onPressed: (){
        // go to edit page
          context.pushNamed('edit');
        },
        child: Text("ویرایش اکانت",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color: MyColor.title_black),)
    );
  }

  Widget UnfollowBtn(){

    return ElevatedButton(onPressed: (){
      var data = {
        "target_user": widget.userModel.id,
        "isfollow": 1
      };
      _followRepository!.Follow(data);
    },
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColor.bg,
          side: BorderSide(
            width: 2.0,
            color: Colors.black
          )
        ),
        child: Text("آنفالو",
        style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color: MyColor.title_black),)
    );

  }


  Widget FollowBtn(){


    return ElevatedButton(onPressed: (){

      var data = {
        "target_user": widget.userModel.id,
        "isfollow": 0
      };
      _followRepository!.Follow(data);
    },
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColor.app_blue
        ),
        child: Text("فالو",
        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),));
  }


  Widget ProfileBtn(){

    if(widget.userModel.email==UserInstance.userModel!.email) return EditProfile();
    else{
      if(widget.userModel.isfollow==1) return UnfollowBtn();
      else return FollowBtn();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.only(right: ScreenSize.width*3, left: ScreenSize.width*3.0,
      top: ScreenSize.width*2,
      bottom: ScreenSize.width*0.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0)
        )
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Text(widget.userModel.name.toString(),style: TextStyle(
                      fontSize: 18.0,color: MyColor.title_black,fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 5.0,),
                    Text(widget.userModel.bio.toString(),style: TextStyle(
                      fontSize: 16.0, color: MyColor.title_black
                    ),)
                  ],
                ),
              ),
              Container(
                width: ScreenSize.width*16,
                height: ScreenSize.width*16,
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
                        image: NetworkImage(widget.userModel.avatar.toString())
                    )
                ),
              )
            ],
          ),
          SizedBox(height: 25.0,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("پست ها"),
              Text("دنبال کنندگان"),
              Text("دنبال شوندگان"),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
                  Text(widget.userModel.post_count.toString(), style: TextStyle(fontSize: 17.0,color: MyColor.title_black,
                  fontWeight: FontWeight.w600),),
              Text(widget.userModel.follower.toString(), style: TextStyle(fontSize: 17.0,color: MyColor.title_black,
                  fontWeight: FontWeight.w600),),
              Text(widget.userModel.following.toString(), style: TextStyle(fontSize: 17.0,color: MyColor.title_black,
                  fontWeight: FontWeight.w600),),
            ],
          ),

          Container(
            width: ScreenSize.width*100,
            margin: EdgeInsets.symmetric(vertical: ScreenSize.height),
            padding: EdgeInsets.symmetric(vertical: ScreenSize.height),
            child: StreamBuilder(
              stream: FollowRepository.streamController.stream,
              builder: (ctx, snap){
                  if(snap.hasData){
                    if(snap.data=="Unfollwed") return FollowBtn();
                     else if(snap.data=="Followed") return UnfollowBtn();
                     else return ProfileBtn();
                  }else{
                    return ProfileBtn();
                  }
              },
            ),
          )

        ],
      ),
    );
  }
}
