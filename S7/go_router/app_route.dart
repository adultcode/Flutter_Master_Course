
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/main.dart';

final GoRouter app_route = GoRouter(

  initialLocation: "/home",
  routes: [
    GoRoute(
      name: "home",
      path: "/home",
      builder: (context, state) {
        return FirstScreen();
      },
    )  ,
    // digiakal.com/s=mobile
    // instagram.com/id=hesam
    GoRoute(
      name: "detail",
      path: "/detail/:name",
      builder: (context, state) {

       final message = state.pathParameters["name"];
        final age = state.uri.queryParameters["age"];
        debugPrint("Age is: $age");
        return SecondScreen(message: message??"empty");
      },
    )
  ]
);