import 'package:flutter/cupertino.dart';
import 'package:neww/api_response.dart';
import 'package:neww/model/timeline_repository.dart';
import 'package:neww/post_model.dart';

class PostViewModel with ChangeNotifier {

  ApiResponse _apiResponse = ApiResponse(1, 'Fetching data');
  ApiResponse get response{ return _apiResponse;}


  Future<void> GetData() async{


    try{
      ApiResponse? _apires = await TimeLineRepository.TimelineRequest();
      if(_apires?.status==200){
        Iterable _list = _apires?.data['posts'];
        List<PostModel> _postlist =
            _list.map((e) => PostModel.fromJson(e)).toList();
        _apiResponse = ApiResponse(200, _postlist);
      }else{
        _apiResponse = ApiResponse(400, "Error");
      }
    }catch(e){
      _apiResponse = ApiResponse(00, "Error");
    }

    notifyListeners();
  }
}