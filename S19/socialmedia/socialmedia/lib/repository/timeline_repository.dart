import 'package:dio/dio.dart';
import 'package:socialmedia/util/myURL.dart';
import 'package:socialmedia/util/my_string.dart';
import 'package:socialmedia/web_service/base_dio.dart';

import '../util/user_instance.dart';
import '../web_service/api_response.dart';

class TimeLineRepository{


  Future<ApiResponse?> TimelineRequest()async{

    var url = Urls.website+Urls.posts;
    BaseDio().client.options.headers["Authorization"] = UserInstance.token;
    print(url);
    try{

      Response response = await BaseDio().client.get(url);
     // print("response: ${response.toString()}");

      if(response.statusCode!=200){
        return new ApiResponse(response.statusCode, MyString.error_400);
      }else{
        return new ApiResponse(response.statusCode, response.data);
      }

    }catch(e){
      print("Error ${e.toString()}");
      return new ApiResponse(000, MyString.error_400);
    }
  }
}