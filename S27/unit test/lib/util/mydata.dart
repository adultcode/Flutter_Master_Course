import 'package:dio/dio.dart';

class MyData{


  Dio dio;
  MyData(this.dio);


  Future<bool> getData({required String title})async{

    try{

      final result = await dio.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: {
          'title': title,
          'body': 'post content',
          'userId':2
        }
      );

      if(result.statusCode!=200){
        return false;
      }else{
        return true;
      }


    }catch(e){
        return false;
    }
  }

  int PowerTwo(var a){
    return a*a;
  }
}