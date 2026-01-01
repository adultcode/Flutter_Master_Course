import 'package:flutter/cupertino.dart';

class School extends ChangeNotifier{
  int classes_count;

  School(this.classes_count);

  void AddClass(){
    classes_count++;
    notifyListeners();
  }
}