import 'package:ci_cd/core/services/api_service.dart';
import 'package:ci_cd/feature/fetch_user/data/data_source/remote/fetch_person_remote_ds.dart';
import 'package:ci_cd/feature/fetch_user/domain/usecase/fetch_person_usecase.dart';
import 'package:get_it/get_it.dart';

import '../feature/fetch_user/data/repository/fetch_person_repoimpl.dart';
import '../feature/fetch_user/domain/repository/fetch_person_repo.dart';


final GetIt sl = GetIt.instance;


void setUpSL(){
  sl.registerLazySingleton<ApiService>(() =>ApiServiceImpl());

  sl.registerLazySingleton<FetchPersonRepository>(() =>FetchPersonRepositoryImpl());
  sl.registerLazySingleton<FetchPersonUseCase>(() =>FetchPersonUseCase());
  sl.registerLazySingleton<FetchPersonRemoteDS>(() =>FetchPersonRemoteDSImpl());

}