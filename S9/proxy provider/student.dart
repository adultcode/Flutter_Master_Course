import 'package:flutter/material.dart';

class Student extends ChangeNotifier{
  int students_count;

  Student( this.students_count);

  void IncreaseStudent(){
    this.students_count+=5;
    notifyListeners();
  }
}