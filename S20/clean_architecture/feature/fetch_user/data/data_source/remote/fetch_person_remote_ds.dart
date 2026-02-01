import 'package:ci_cd/core/constant/string_const.dart';
import 'package:ci_cd/core/services/api_service.dart';
import 'package:ci_cd/feature/fetch_user/data/model/person_model.dart';
import 'package:dio/dio.dart';

import '../../../../../core/service_locator.dart';
import '../../../../../core/services/api_response.dart';

abstract class FetchPersonRemoteDS{
  Future<ApiResponse> fetchPerson();
}


class FetchPersonRemoteDSImpl implements FetchPersonRemoteDS{
  final ApiService apiService = sl<ApiService>();
  @override
  Future<ApiResponse> fetchPerson()async {
    // TODO: implement fetchPerson

    try{
      Response response = await apiService.getPersonList(StringConst.api_url);

      if(response.statusCode==200){
        Iterable data = response.data;
        List<PersonModel> person_list =
        data.map((e) => PersonModel.fromjson(e)).toList();

        return ApiResponse.completed(data: person_list,server_code: response.statusCode);
      }else{
        return ApiResponse.error(data: 'Error!!!',server_code: response.statusCode);
      }
    }on DioException catch(e){
      return ApiResponse.error(data: e.response!.data,server_code: e.response!.statusCode);

    }
  }

}