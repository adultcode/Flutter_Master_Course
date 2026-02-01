import 'package:dio/dio.dart';

abstract class ApiService{

  Future<Response> getPersonList(String url);
}


class ApiServiceImpl implements ApiService{
  @override
  Future<Response> getPersonList(String url) async{
    // TODO: implement getPersonList

    var response = await Dio().get(url);
    return response;

  }

}