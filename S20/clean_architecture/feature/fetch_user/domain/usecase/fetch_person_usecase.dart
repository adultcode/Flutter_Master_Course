import 'package:ci_cd/feature/fetch_user/domain/repository/fetch_person_repo.dart';

import '../../../../core/service_locator.dart';
import '../../../../core/services/api_response.dart';

class FetchPersonUseCase{
  final FetchPersonRepository fetchPersonRepository = sl<FetchPersonRepository>();

  Future<ApiResponse> FetchPerson(){
    return fetchPersonRepository.FetchPerson();
  }
}