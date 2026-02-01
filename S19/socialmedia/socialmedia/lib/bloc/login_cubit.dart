import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/model/user_model.dart';
import 'package:socialmedia/repository/login_repository.dart';
import 'package:socialmedia/state/login_state.dart';
import 'package:socialmedia/web_service/base_dio.dart';

import '../util/user_instance.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit(): super(InitialState());
  LoginRepository? _loginRepository;
  SharedPreferences? prefs;
  
  void SendRequest(var data)async{
    prefs = await SharedPreferences.getInstance();
    _loginRepository = LoginRepository();
    emit(LoadingState());
    var result =await _loginRepository!.LoginRequest(data);

    if(result?.status==200){

      UserModel _usermodel = UserModel.fromJson(result.data);
      prefs?.setString('token', result.data['token']);
      prefs?.setString("user", jsonEncode(_usermodel.toJson()));
      UserInstance.token = "Token ${result.data['token']}";
      UserInstance.userModel = _usermodel;

      BaseDio().client.options.headers["Authorization"] = "Token ${result.data['token']}";
      emit(SuccessState(_usermodel));
    }else{
      emit(ErrorState(result.data));
    }

  }
}