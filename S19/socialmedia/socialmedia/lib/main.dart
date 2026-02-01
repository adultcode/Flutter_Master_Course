import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socialmedia/model/post_model.dart';
import 'package:socialmedia/model/user_model.dart';
import 'package:socialmedia/pages/form/login_page.dart';
import 'package:socialmedia/pages/form/signup_page.dart';
import 'package:socialmedia/pages/main_form.dart';
import 'package:socialmedia/pages/post_page.dart';
import 'package:socialmedia/pages/profile_edit_page.dart';
import 'package:socialmedia/pages/profile_page.dart';
import 'package:socialmedia/pages/send_post_page.dart';
import 'package:socialmedia/pages/splash_screen.dart';
import 'package:socialmedia/pages/timeline_page.dart';
import 'package:socialmedia/util/screen_size.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MyHomePage(),
    ),
    GoRoute(
        name: 'timeline',
        path: '/timeline',
        builder: (context, state) =>  TimeLinePage(),
    ),
    GoRoute(
      name: 'mainform',
      path: '/mainform',
      builder: (context, state) =>  MainForm(),
    ),
    GoRoute(
      name: 'sendpost',
      path: '/sendpost',
      builder: (context, state) =>  SendPostPage(),
    ),
    GoRoute(
      name: 'postpage',
      path: '/postpage',
      builder: (context, state) =>  PostPage(state.extra as PostModel),
    ),
    GoRoute(
      name: 'profile',
      path: '/profile',
      builder: (context, state) =>  ProfilePage(state.extra as UserModel),
    ),
    GoRoute(
      name: 'edit',
      path: '/edit',
      builder: (context, state) =>  ProfileEditPage(),
    )
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'IranSans'
      ),
    //  routeInformationParser: _router.routeInformationParser,
      //routerDelegate: _router.routerDelegate,
      routerConfig: _router,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Widget> _pages = [];
  var page_index = 0;
  @override
  void initState() {
    // TODO: implement initState
    _pages.add(LoginPage(onLoginCallback));
    _pages.add(SignUpPage(onSignupCallback));
  }

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
  Widget build(BuildContext context) {
    ScreenSize.height = MediaQuery.of(context).size.height/100;
    ScreenSize.width = MediaQuery.of(context).size.width/100;

    return Scaffold(
      body: SafeArea(
        child: SplashScreen(),
      ),
    );
  }
}
