import 'dart:async';

import 'package:dio/dio.dart';
import 'package:socialmedia/util/myURL.dart';
import 'package:socialmedia/util/my_string.dart';

import '../util/user_instance.dart';
import '../web_service/api_response.dart';
import '../web_service/base_dio.dart';

class SendCommentRepository{

  static StreamController streamController = StreamController<int>.broadcast();
  void SendComment(var _data)async{
    var res = await SendCommentRequest(_data);
    if(res?.status==200){
      var result = res?.data['status'];
      if(result=="done"){
        streamController.add(1);
      }else{
        streamController.add(0);
      }
    }else{
      streamController.add(0);
    }

  }

  Future<ApiResponse?> SendCommentRequest(var mydata)async{
    var url = Urls.website+Urls.send_comment;
    BaseDio().client.options.headers["Authorization"] = UserInstance.token;

    try{


      Response response = await BaseDio().client.post(url,data: mydata);
      print("respinse: ${response.toString()}");
      if(response.statusCode!=200){
        return new ApiResponse(response.statusCode, MyString.error_400);
      }else{
        return new ApiResponse(response.statusCode, response.data);
      }

    }catch(e){
      print("Error: ${e.toString()}");
      return new ApiResponse(000, MyString.catch_error);
    }
  }
}