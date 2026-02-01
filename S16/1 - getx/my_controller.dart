import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyController extends GetxController{


  final my_name = 'Empty'.obs;

  final myname_controller = TextEditingController();

  updateName(String name){
    my_name(name);
  }

}