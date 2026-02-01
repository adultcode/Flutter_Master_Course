import 'package:flutter/material.dart';

class WatchBtn extends StatelessWidget {
  const WatchBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 35.0),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.play_circle,color: Colors.white,),
          SizedBox(width: 15.0,),
          Text("Watch now",style: TextStyle(color: Colors.white),)
        ],
      ),

    );
  }
}
