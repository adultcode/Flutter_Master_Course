
import 'package:dio/dio.dart';
import 'package:socialmedia/util/myURL.dart';
import 'package:socialmedia/web_service/base_dio.dart';

import '../util/my_string.dart';
import '../util/user_instance.dart';
import '../web_service/api_response.dart';

class LikePostsRepository{

  Future<ApiResponse> LikePostRequest(var userdata)async{
    var _url = Urls.website+Urls.like;
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