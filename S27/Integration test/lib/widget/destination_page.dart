import 'package:flutter/material.dart';

class DestinationPage extends StatelessWidget {
  var name;


  DestinationPage(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("This is destination page....$name"),
      ),
    );
  }
}
