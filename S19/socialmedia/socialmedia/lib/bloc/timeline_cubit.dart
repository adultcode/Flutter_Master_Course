import 'package:bloc/bloc.dart';
import 'package:socialmedia/model/post_model.dart';
import 'package:socialmedia/repository/timeline_repository.dart';
import 'package:socialmedia/state/timeline_state.dart';

class TimeLineCubit  extends Cubit<TimelineState>{

  TimeLineCubit() : super(InitialState());

 TimeLineRepository? _timeLineRepository;

  void SendRequest()async{

    emit(LoadingState());
    _timeLineRepository = TimeLineRepository();
    var result =await _timeLineRepository?.TimelineRequest();

    if(result?.status==200){

      Iterable _list = result?.data["posts"];
      List<PostModel> _postlist = 
          _list.map((e) => PostModel.fromJson(e)).toList();

      emit(SuccessState(_postlist));


    }else{
      emit(ErrorState(result?.data));
    }
  }

}