import 'package:ci_cd/feature/fetch_user/presentation/cubit/person_cubit.dart';
import 'package:ci_cd/feature/fetch_user/presentation/cubit/person_state.dart';
import 'package:ci_cd/feature/fetch_user/presentation/ui/person_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({Key? key}) : super(key: key);

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PersonCubit>().FetchPersonList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text('Clean Architecture'),
      ),
      body: Container(
        child: BlocBuilder<PersonCubit,PersonState>(
          builder: (context, state) {
            if(state is PersonDone){
              return ListView.builder(
                itemCount: state.person_list.length,
                itemBuilder: (context, index) => PersonItem(state.person_list[index]),
              );
            }else if(state is PersonError){
              return Center(child: Text(state.data),);
            }else if( state is PersonLoading)
              return Center(child: CircularProgressIndicator(),);
            else return Container();
          },
        ),
      ),
    );
  }
}
