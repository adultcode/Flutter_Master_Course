import 'package:flutter/material.dart';

class BuyBtn extends StatelessWidget {
  const BuyBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 35.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          color: Colors.white
        ),
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      child: Text("19.5\$ Bluray Disk",style: TextStyle(color: Colors.white),),

    );
  }
}
