
import 'package:ci_cd/feature/fetch_user/presentation/cubit/person_cubit.dart';
import 'package:ci_cd/feature/fetch_user/presentation/ui/person_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/service_locator.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setUpSL();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=> PersonCubit())
        ],

        child: MaterialApp(
          home: PersonPage(),
        ));
  }
}


