import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/model/user_model.dart';
import 'package:socialmedia/util/my_string.dart';

import '../util/myURL.dart';
import '../util/user_instance.dart';
import '../web_service/api_response.dart';
import '../web_service/base_dio.dart';

class EditProfileRepository{

  static StreamController streamController = StreamController<String>.broadcast();
  SharedPreferences? preferences;
  void EditProfile(var _data)async{
    preferences = await SharedPreferences.getInstance();
    var temp = preferences?.getString('user');
    var user = UserModel.fromJson(jsonDecode(temp!));

    var res = await EditProfileRequest(_data);
    if(res!.status==200){
      print("status 200");
      var result = res!.data['status'];
      user.name = result['name'];
      user.avatar = result['img'];
      user.bio = result['bio'];
      preferences?.setString('user', jsonEncode(user.toJson()));
      UserInstance.userModel = user;
      streamController.add("done");

    }else{
      print("status error");
      streamController.add('Error');
    }
  }

  Future<ApiResponse?> EditProfileRequest(var _data)async{
    var _url = Urls.website+Urls.edit_profile;
    BaseDio().client.options.headers["Authorization"] = UserInstance.token;
    print(_url);
    try{

      Response res = await BaseDio().client.post(_url,data:_data);
      if(res.statusCode!=200){
        return new ApiResponse(res.statusCode, MyString.error_400);
      }else{
        return new ApiResponse(res.statusCode, res.data);
      }
    }catch(e){
      print("Error: ${e.toString()}");
      return new ApiResponse(000, MyString.catch_error);
    }
  }

}