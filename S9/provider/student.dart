import 'package:flutter/material.dart';

class Student extends ChangeNotifier{
  var name;
  int age;

  Student(this.name, this.age);

  void IncreaseAge(String newName){
    this.age+=5;
    this.name = newName;
    notifyListeners();
  }
}