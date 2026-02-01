import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/bloc/timeline_cubit.dart';
import 'package:socialmedia/state/timeline_state.dart';
import 'package:socialmedia/util/myURL.dart';
import 'package:socialmedia/util/user_instance.dart';
import 'package:socialmedia/widgets/post_item.dart';

import '../model/post_model.dart';
import '../util/my_color.dart';
import '../util/screen_size.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  TimeLineCubit? _cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = TimeLineCubit();
    _cubit?.SendRequest();
    //print(UserInstance.token);
  }

  Widget list_items(List<PostModel> postlist){

    return ListView.builder(
      itemCount: postlist.length,
      itemBuilder: (context,index){
        return PostItem(postlist[index]);
      },

    );
  }

  Widget _ui(){
    return BlocBuilder<TimeLineCubit,TimelineState>(
      bloc: _cubit,
      builder: (context,state){
        if(state is LoadingState){
          return Container(child: CircularProgressIndicator(),);
        }else if (state is ErrorState){
          return Center(child: Text("Error: ${state.data}"));
        }else if (state is SuccessState){
          return list_items(state.postlist);
        }else{
          return Text("Init state");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          context.pushNamed('sendpost');
        },
      ),
      appBar: AppBar(

        title: InkWell(
            onTap: ()async{
              print("click...");
              SharedPreferences? pref =await SharedPreferences.getInstance();
              pref.remove('token');
              context.go('/');
            },
            child: Text("خروج",style: TextStyle(color: MyColor.title_black),)),
        backgroundColor: MyColor.timeline_bg,
        elevation: 1.0,
        actions: [
      Container(
      margin: EdgeInsets.only(right: ScreenSize.width*4),
      width: ScreenSize.width*10,
      height: ScreenSize.width*10,
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.all(Radius.circular(14.0)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0,1),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.3)
            )
          ],
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(Urls.website+UserInstance.userModel!.avatar.toString()),
              fit: BoxFit.cover
          )
      ),
    )
        ],
      ),
      body: Container(
    color: MyColor.bg,
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width*4),
        child: _ui()
      ),
    );
  }
}
