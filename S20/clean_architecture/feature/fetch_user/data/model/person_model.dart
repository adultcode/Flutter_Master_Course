import 'package:ci_cd/feature/fetch_user/domain/entity/person_entity.dart';

class PersonModel extends PersonEntity{
  String? name;
  String? city;
  PersonModel({this.name, this.city}): super(city: city,name: name);

  factory PersonModel.fromjson(Map<String,dynamic> map){
  return PersonModel(
    name: map['name'],
    city: map['city']
  );
  }

}