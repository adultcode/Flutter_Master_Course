import 'dart:async';

import 'package:dio/dio.dart';
import 'package:socialmedia/util/myURL.dart';
import 'package:socialmedia/util/my_string.dart';

import '../util/user_instance.dart';
import '../web_service/api_response.dart';
import '../web_service/base_dio.dart';

class SendPostRepository{

  static StreamController streamController = StreamController<int>.broadcast();
  void SendPost(var _data)async{
    var res = await SendPostRequest(_data);
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

  Future<ApiResponse?> SendPostRequest(var mydata)async{
    var url = Urls.website+Urls.send_post;
    BaseDio().client.options.headers["Authorization"] = UserInstance.token;

    try{


      Response response = await BaseDio().client.post(url,data: mydata);
      print("response: ${response.toString()}");
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