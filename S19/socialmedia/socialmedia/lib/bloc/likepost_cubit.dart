
import 'package:bloc/bloc.dart';
import 'package:socialmedia/model/post_model.dart';
import 'package:socialmedia/repository/likepost_repository.dart';
import 'package:socialmedia/repository/timeline_repository.dart';
import 'package:socialmedia/state/likepost_state.dart';

class LikePostCubit  extends Cubit<LikePostState>{

  LikePostCubit() : super(InitialState());

  LikePostsRepository? _likePostsRepository;

  void SendRequest(var data)async{

    emit(LoadingState());
    _likePostsRepository = LikePostsRepository();
    var result =await _likePostsRepository?.LikePostRequest(data);

    if(result?.status==200){

      var status = result?.data['status'];

     if(status=='Unliked'){
       emit(UnLikedState(status));
     }else{
       emit(LikedState(status));
     }


    }else{
      emit(ErrorState(result?.data));
    }
  }

}