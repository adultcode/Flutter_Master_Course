import 'package:untitled/person_model.dart';

abstract class PersonEvent{}

class GetPersonEvent extends PersonEvent{}

class AddMoneyEvent extends PersonEvent{}
class SpendMoneyEvent extends PersonEvent{}
class AddMoneyAmountEvent extends PersonEvent{
  int amount;
  AddMoneyAmountEvent(this.amount);
}