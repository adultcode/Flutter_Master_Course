import 'package:untitled/person_model.dart';

abstract class PersonState{}

class PersonInitialState extends PersonState{}


class PersonLoadingState extends PersonState{}
class PersonErrorState extends PersonState{
  String message;
  PersonErrorState(this.message);
}

class PersonResultState extends PersonState{
  final Person person;
  PersonResultState(this.person);
}