import 'package:flutter/material.dart';

class MyInheritedWidget extends InheritedWidget {
  const MyInheritedWidget({Key? key,required this.child,required this.count,
    required this.addCounter})
      : super(key: key, child: child);

  final Widget child;
  final Function addCounter;
  // message of our inherited widget class
  final int count;

  static MyInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return oldWidget.count != count;
  }
}