import 'package:ci_cd/core/services/api_response.dart';
import 'package:ci_cd/feature/fetch_user/data/data_source/remote/fetch_person_remote_ds.dart';
import 'package:ci_cd/feature/fetch_user/domain/repository/fetch_person_repo.dart';

import '../../../../core/service_locator.dart';

class FetchPersonRepositoryImpl implements FetchPersonRepository{
  final FetchPersonRemoteDS  fetchPersonRemoteDS = sl<FetchPersonRemoteDS>();
  @override
  Future<ApiResponse> FetchPerson() async{
    // TODO: implement FetchPerson
    var response = await fetchPersonRemoteDS.fetchPerson();
    return response;

  }

}