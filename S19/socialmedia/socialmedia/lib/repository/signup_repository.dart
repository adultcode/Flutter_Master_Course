
import 'package:dio/dio.dart';
import 'package:socialmedia/util/myURL.dart';
import 'package:socialmedia/web_service/base_dio.dart';

import '../util/my_string.dart';
import '../web_service/api_response.dart';

class SignupRepository{

  Future<ApiResponse> SignupRequest(var userdata)async{
    var _url = Urls.website+Urls.signup;
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