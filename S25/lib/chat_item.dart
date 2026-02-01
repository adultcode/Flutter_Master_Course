import 'package:flutter/material.dart';
import 'package:untitled/chat_model.dart';

class ChatItem extends StatelessWidget {
  ChatModel _chatModel;


  ChatItem(this._chatModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0,horizontal: 5.0),
      child: Row(
        children: [
          Container(
            child: Text("@${_chatModel.name} : ",style: TextStyle(fontSize: 17.0),),

          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 6.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            child: Text(_chatModel.content,style: TextStyle(color: Colors.white,fontSize: 16.0),),
          )
        ],
      ),
    );
  }
}
