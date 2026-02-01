import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/model/user_model.dart';
import 'package:socialmedia/repository/signup_repository.dart';
import 'package:socialmedia/state/login_state.dart';
import 'package:socialmedia/web_service/base_dio.dart';

import '../util/user_instance.dart';

class SignupCubit extends Cubit<LoginState>{
  SignupCubit(): super(InitialState());
  SignupRepository? _signupRepository;
  SharedPreferences? prefs;

  void SendRequest(var data)async{
    prefs = await SharedPreferences.getInstance();
    _signupRepository = SignupRepository();
    emit(LoadingState());
    var result =await _signupRepository!.SignupRequest(data);

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