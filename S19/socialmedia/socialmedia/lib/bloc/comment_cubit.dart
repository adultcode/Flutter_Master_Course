import 'package:bloc/bloc.dart';
import 'package:socialmedia/model/comment_model.dart';
import 'package:socialmedia/model/post_model.dart';
import 'package:socialmedia/repository/comment_repository.dart';
import 'package:socialmedia/state/comment_state.dart';


class CommentCubit  extends Cubit<CommentState>{

  CommentCubit() : super(InitialState());

  CommentRepository? _commentRepository;

  void SendRequest(var data)async{

    emit(LoadingState());
    _commentRepository = CommentRepository();
    var result =await _commentRepository?.CommentRequest(data);

    if(result?.status==200){

      Iterable _list = result?.data["comments"];
      List<CommentModel> _cmlist =
      _list.map((e) => CommentModel.fromJson(e)).toList();

      emit(SuccessState(_cmlist));


    }else{
      emit(ErrorState(result?.data));
    }
  }

}