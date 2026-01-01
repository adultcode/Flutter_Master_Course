import 'package:bloc/bloc.dart';
import 'package:untitled/person_event.dart';
import 'package:untitled/person_model.dart';
import 'package:untitled/person_state.dart';

class PersonBloc extends Bloc<PersonEvent,PersonState>{

  Person _person = Person(name: "Flutter",money: 100);


  PersonBloc():super(PersonInitialState()){

    on<GetPersonEvent>((event, emit) async{

      emit(PersonLoadingState());

      await Future.delayed(Duration(seconds: 2));

      emit(PersonResultState(_person));
    },);

    on<AddMoneyEvent>((event, emit) async{

      emit(PersonLoadingState());

      await Future.delayed(Duration(seconds: 1));



      _person = _person.copyWith(money: _person.money + 10);
      emit(PersonResultState(_person));

    },);

    on<SpendMoneyEvent>((event, emit) async{
      emit(PersonLoadingState());

      await Future.delayed(Duration(seconds: 1));
      _person = _person.copyWith(money: _person.money - 10);
      if(_person.money<80){
        emit(PersonErrorState("Warning...."));
      }else{
        emit(PersonResultState(_person));

      }

    },);


    on<AddMoneyAmountEvent>((event, emit) async{
      emit(PersonLoadingState());

      await Future.delayed(Duration(seconds: 1));



      _person = _person.copyWith(money: _person.money + event.amount);
      emit(PersonResultState(_person));

    },);

  }
}