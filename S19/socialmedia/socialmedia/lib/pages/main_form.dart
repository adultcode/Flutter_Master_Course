import 'package:flutter/material.dart';

import 'form/login_page.dart';
import 'form/signup_page.dart';

class MainForm extends StatefulWidget {
  const MainForm({Key? key}) : super(key: key);

  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  List<Widget> _pages = [];
  var page_index = 0;
  void onLoginCallback(){
    print("Login callback clicked...");
    setState(() {
      page_index=1;
    });
  }
  void onSignupCallback(){
    print("Signup callback clicked...");
    setState(() {
      page_index=0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages.add(LoginPage(onLoginCallback));
    _pages.add(SignUpPage(onSignupCallback));

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        child:  _pages[page_index],
      ),
    );
  }
}
