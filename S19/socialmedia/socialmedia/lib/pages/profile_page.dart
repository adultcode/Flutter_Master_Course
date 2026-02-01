import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/bloc/profile_cubit.dart';
import 'package:socialmedia/model/user_model.dart';
import 'package:socialmedia/state/profile_state.dart';
import 'package:socialmedia/util/my_color.dart';
import 'package:socialmedia/util/screen_size.dart';
import 'package:socialmedia/widgets/post_item.dart';
import 'package:socialmedia/widgets/profile_info.dart';

class ProfilePage extends StatefulWidget {
  UserModel userModel;


  ProfilePage(this.userModel);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  ProfileCubit? cubit;
  //var _data;
  @override
  void initState() {
    // TODO: implement initState
    cubit = ProfileCubit();
    cubit!.SendRequest(widget.userModel.id.toString());
  }

  Widget UI(SuccessState state){
    return NestedScrollView(
      headerSliverBuilder: (context,Isscrolled){
        return <Widget>[
          SliverToBoxAdapter(child: ProfileInfo(state.userModel),)
        ];
      },
      body: ListView.builder(
        itemCount: state.postlist.length,
        itemBuilder: (ctx,index){
          return PostItem(state.postlist[index]);
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: MyColor.bg,
          width: ScreenSize.width*100,
          height: ScreenSize.height*100,
          child: BlocBuilder<ProfileCubit,ProfileState>(
            bloc: cubit,
            builder: (ctx,state){
              if(state is SuccessState){
                return   UI(state);
              }else if (state is ErrorState){
                return Text("Error....");
              }else if (state is ErrorState){
                return Text("Loading....");
              }
              else {
                return Text("Nothing...");
              }
            },
          ),
        ),
      ),
    );
  }
}
