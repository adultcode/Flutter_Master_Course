import 'package:dio/dio.dart';

class BaseDio{

  static BaseDio? _baseDio;
  Dio? _dio;
  factory BaseDio(){
    if(_baseDio==null) _baseDio = BaseDio._();
    return _baseDio!;
  }
  BaseDio._(){
    _dio = Dio();
  }
  get client => _dio;
}

