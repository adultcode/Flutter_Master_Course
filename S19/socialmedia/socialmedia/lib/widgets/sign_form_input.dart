import 'package:flutter/material.dart';

import '../util/my_color.dart';

class SignFormInput extends StatelessWidget {

  String hint;
  var _controller;
  Icon _icon;
  bool isPassword;


  SignFormInput(this.hint, this._controller, this._icon, this.isPassword);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(5.0),
        color: Colors.white,
        border: Border.all(
          color: MyColor.input_border,
          width: 1.3
        )
      ),
      child: TextField(
        textAlign: TextAlign.right,
        controller: _controller,
        obscureText: isPassword,
        style: TextStyle(fontSize: 18,color: MyColor.title_black),
        decoration: InputDecoration(
          suffixIcon:_icon,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(fontSize: 18,color: MyColor.input_border)
        ),
      ),
    );
  }
}
