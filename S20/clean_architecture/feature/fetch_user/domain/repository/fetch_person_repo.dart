import '../../../../core/services/api_response.dart';

abstract class FetchPersonRepository{

  Future<ApiResponse> FetchPerson();
}