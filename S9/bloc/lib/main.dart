// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/person_bloc.dart';
import 'package:untitled/person_event.dart';
import 'package:untitled/person_state.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Demo',
      // home: BlocProvider(
      //   create: (context) => PersonBloc(),
      //   child: PersonPage(),
      // ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PersonBloc(),),
        ],
        child: PersonPage(),
      ),

    );
  }
}



class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late PersonBloc _secondBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _secondBloc = PersonBloc();
    BlocProvider.of<PersonBloc>(context).add(GetPersonEvent());
    _secondBloc.add(GetPersonEvent());
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Person page");
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc"),

      ),
      body: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 60,),

          Text("First bloc"),
          BlocBuilder<PersonBloc,PersonState>(

            builder: (context, state) {

            if(state is PersonLoadingState){

              return Center(child: CircularProgressIndicator(),);
            }
            if(state is PersonResultState){
              return Text("Money: ${state.person.money}",style: TextStyle(fontSize: 20),);
            }

            if(state is PersonErrorState){
              return Text("Money: ${state.message}",style: TextStyle(fontSize: 20,color: Colors.red),);

            }
            return Text("init");


          },),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () {
                BlocProvider.of<PersonBloc>(context).add(AddMoneyEvent());

              }, child: Text("Add money")),

              ElevatedButton(onPressed: () {
                BlocProvider.of<PersonBloc>(context).add(SpendMoneyEvent());

              }, child: Text("Spend money"))
            ],
          ),


          Text("Second bloc"),
          BlocConsumer<PersonBloc,PersonState>(
           bloc: _secondBloc,
            listener: (context, state) {
              debugPrint("Second state is: $state");

              if(state is PersonErrorState){
                debugPrint("---------- Error --------- ${state.message}");
              }
            },
            builder: (context, state) {

            if(state is PersonLoadingState){

              return Center(child: CircularProgressIndicator(),);
            }
            if(state is PersonResultState){
              return Text("Money: ${state.person.money}",style: TextStyle(fontSize: 20),);
            }

            if(state is PersonErrorState){
              return Text("second Money: ${state.message}",style: TextStyle(fontSize: 20,color: Colors.red),);

            }
            return Text("init");


          },),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () {
                _secondBloc.add(AddMoneyEvent());

              }, child: Text("Add money")),

              ElevatedButton(onPressed: () {
                _secondBloc.add(SpendMoneyEvent());

              }, child: Text("Spend money")) ,
              ElevatedButton(onPressed: () {
                _secondBloc.add(AddMoneyAmountEvent(50));

              }, child: Text("Add 50"))
            ],
          )



        ],
      ),
    );
  }
}
