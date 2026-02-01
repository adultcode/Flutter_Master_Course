import '../../domain/entity/person_entity.dart';

abstract class PersonState{}


class PersonDone extends PersonState {
  final List<PersonEntity> person_list;
  PersonDone(this.person_list);
}
class PersonInit extends PersonState{}
class PersonLoading extends PersonState{}
class PersonError extends PersonState{
  var data;
  PersonError(this.data);
}