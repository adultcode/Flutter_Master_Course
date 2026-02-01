import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/model/post_model.dart';
import 'package:socialmedia/state/comment_state.dart';
import 'package:socialmedia/util/global_key.dart';
import 'package:socialmedia/widgets/comment_box.dart';
import 'package:socialmedia/widgets/comment_item.dart';
import 'package:socialmedia/widgets/post_detail.dart';

import '../bloc/comment_cubit.dart';
import '../bloc/likepost_cubit.dart';
import '../util/myURL.dart';
import '../util/my_color.dart';
import '../util/screen_size.dart';

class PostPage extends StatefulWidget {
  PostModel? postModel;


  PostPage(this.postModel);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  CommentCubit? cubit;
  @override
  void initState() {
    // TODO: implement initState

    cubit = CommentCubit();
    var data = {
      "postid": widget.postModel?.id
    };
    cubit?.SendRequest(data);
  }
/*
  listview
     listview
     sliver
 */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKeyVariable.rootScafoldMessengerkey,
      body: SafeArea(
        child: Container(
          color: MyColor.bg,
          height: ScreenSize.height*100,
          child: Stack(
            children: [

              CustomScrollView(
                slivers: [
                  // post detail
                  SliverToBoxAdapter(
                    child: PostPageDetail(widget.postModel!),
                  ),
                  // comment list
                  BlocBuilder<CommentCubit,CommentState>(
                    bloc: cubit,
                    builder: (ctx, state){

                      if(state is SuccessState){
                        return SliverToBoxAdapter(
                          child: Container(
                            margin: EdgeInsets.only(top: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0),
                              )
                            ),
                            child: ListView.builder(
                              itemCount: state.commentlist.length,
                              shrinkWrap: true,
                              itemBuilder: (ctx,index){
                                return CommentItem(state.commentlist[index]);
                              },
                            ),
                          ),
                        );
                      }else if(state is LoadingState){
                        return SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator(),),
                        );
                      }else if (state is ErrorState){
                        return Center(child: Text("Error: ${state.data}"),);
                      }else{
                        return Container();
                      }
                    },
                  )

                ],
              ),

              // comment box
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CommentBox(widget.postModel!.id.toString()),
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}
