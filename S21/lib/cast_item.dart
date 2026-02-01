import 'package:flutter/material.dart';
import 'package:untitled3/person.dart';
import 'package:untitled3/screen_size.dart';

class CastItem extends StatelessWidget {
  Person person;


  CastItem(this.person);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.height*6,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Container(
            width: 60.0,
            height: 61.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(person.img.toString())
              )
            ),
          ),
          SizedBox(width: 10.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(person.role.toString(),style: TextStyle(color: Colors.red),),
              SizedBox(height: 3.0,),
              Text(person.name.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,
              fontSize: 13),)
            ],
          )
        ],
      ),
    );
  }
}
