import 'package:flutter/material.dart';
import 'package:socialmedia/util/my_color.dart';
import 'package:socialmedia/util/screen_size.dart';
import 'package:socialmedia/util/user_instance.dart';

import '../repository/send_comment_repository.dart';
import '../util/global_key.dart';
import '../util/myURL.dart';
import '../util/my_string.dart';

class CommentBox extends StatelessWidget {
  var comment_controller  = TextEditingController();
  String postid;
  SendCommentRepository? _commentRepository;
  String status = "";

  CommentBox(this.postid){
    _commentRepository = SendCommentRepository();

    SendCommentRepository.streamController.stream.listen((data) {

      if(data==1){
        comment_controller.clear();
        status = MyString.comment_done;
      }else{

        status = MyString.catch_error;
      }

      var snackBar = SnackBar(content: Text(status,));
      ScaffoldMessenger.of(GlobalKeyVariable.rootScafoldMessengerkey.currentContext!).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.width*100,
      height: ScreenSize.height*10,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(0,1),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.2)
            )
          ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0)
        )
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: ScreenSize.width*3.5,
        vertical: ScreenSize.height*1.3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          border: Border.all(
            width: 1.0,
            color: MyColor.input_border
          )
        ),
        child: Row(
          children: [

            Container(
              height: ScreenSize.width*9,
              width: ScreenSize.width*13,
              margin: EdgeInsets.only(left: ScreenSize.width*1.5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: IconButton(
                onPressed: (){
                  var _data = {
                    "postid": postid,
                    "comment": comment_controller.text.toString()
                  };
                  _commentRepository?.SendComment(_data);
                },
                icon: Icon(Icons.arrow_back,color: Colors.white,),
              ),
            ),
            Expanded(child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(
                controller: comment_controller,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "ارسال نظر",
                  hintStyle: TextStyle(fontSize: 18.0,color: MyColor.input_border)
                ),
              ),
            )),
            Container(
              width: ScreenSize.width*10,
              height: ScreenSize.width*10,
              margin: EdgeInsets.only(right: 5.0),
              decoration: BoxDecoration(

                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(Urls.media+UserInstance.userModel!.avatar.toString())
                  )
              ),

            ),

          ],
        ),

      ),
    );
  }
}
