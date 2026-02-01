import 'dart:async';

import 'package:dio/dio.dart';

import '../util/myURL.dart';
import '../util/my_string.dart';
import '../util/user_instance.dart';
import '../web_service/api_response.dart';
import '../web_service/base_dio.dart';

class FollowRepository{

  static StreamController streamController = StreamController<String>.broadcast();
  void Follow(var _data)async{
    print(_data);

    var res = await FollowRequest(_data);
    if(res?.status==200){
      var result = res.data['status'];
      streamController.add(result);
    }else{
      streamController.add("Error");
    }

  }
  Future<ApiResponse> FollowRequest(var userdata)async{
    var _url = Urls.website+Urls.follow;
    BaseDio().client.options.headers["Authorization"] = UserInstance.token;
    print(_url);
    try{
      Response response = await BaseDio().client.post(_url,data:userdata);
      print("res: ${response.toString()}");
      // var res = response.data;
      if(response.statusCode==200){
        return new ApiResponse(response.statusCode, response.data);
      }else{
        return new ApiResponse(response.statusCode, MyString.error_400);
      }

    }catch(e){
      print("Error: ${e.toString()}");
      return ApiResponse(000, MyString.catch_error);
    }
  }
}