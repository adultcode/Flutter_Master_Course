import 'package:ci_cd/core/services/api_response.dart';
import 'package:ci_cd/feature/fetch_user/domain/usecase/fetch_person_usecase.dart';
import 'package:ci_cd/feature/fetch_user/presentation/cubit/person_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service_locator.dart';

class PersonCubit extends Cubit<PersonState>{
  PersonCubit():super(PersonInit());

  final FetchPersonUseCase _fetchPersonUseCase = sl<FetchPersonUseCase>();

  void FetchPersonList() async{
    emit(PersonLoading());
    ApiResponse apiResponse = await _fetchPersonUseCase.FetchPerson();

    if(apiResponse.status == Status.COMPLETED){
      emit(PersonDone(apiResponse.data));
    }else{
      print("api error ${apiResponse.data}");
      emit(PersonError(apiResponse.data));
    }
  }
}