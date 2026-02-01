import '../api_response.dart';
import 'package:dio/dio.dart';
class TimeLineRepository{

  static Future<ApiResponse?> TimelineRequest()async{

    var url = 'http://10.0.2.2:8000/posts/';
    print(url);
    try{


      Response response = await Dio().get(url);
      print(response.toString());
      if(response.statusCode!=200){
        return new ApiResponse(response.statusCode, "Error400");
      }else{
        return new ApiResponse(response.statusCode, response.data);
      }
    }catch(e){
      print("Error: ${e.toString()}");
      return new ApiResponse(000, "Error!!!");
    }
  }
}