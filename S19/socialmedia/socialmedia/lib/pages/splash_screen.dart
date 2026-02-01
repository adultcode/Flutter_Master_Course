import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/model/user_model.dart';
import 'package:socialmedia/util/user_instance.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences? pref;
  UserModel? user;

  void getData()async{
    pref = await SharedPreferences.getInstance();
    if(pref?.containsKey("token")==false){
      await Future.delayed(const Duration(seconds: 3),(){
        context.goNamed('mainform');
      });
    }else{

      var temp = pref?.getString('user');
      user = UserModel.fromJson(jsonDecode(temp!));
      UserInstance.token = "Token ${pref!.getString('token')}";
      UserInstance.userModel = user;
      await Future.delayed(const Duration(seconds: 3),(){
        context.goNamed('timeline');
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();

  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Center(
        child: FlutterLogo(size: 250.0),
      ),
    );
  }
}
