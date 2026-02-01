import 'package:ci_cd/feature/fetch_user/domain/entity/person_entity.dart';
import 'package:flutter/material.dart';

class PersonItem extends StatelessWidget {

  PersonEntity personEntity;
  PersonItem(this.personEntity);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      child: Text("${personEntity.name} from ${personEntity.city}",
      style: TextStyle(fontSize: 17,color: Colors.black),),
    );
  }
}
