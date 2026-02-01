import 'package:socialmedia/model/comment_model.dart';
import 'package:socialmedia/model/post_model.dart';

import '../model/user_model.dart';

abstract class CommentState{
  const CommentState();


}
class InitialState extends CommentState{
  InitialState();
}
class LoadingState extends CommentState{
  LoadingState();
}
class ErrorState extends CommentState{
  var data;
  ErrorState(this.data);
}
class SuccessState extends CommentState{
  List<CommentModel> commentlist;
  SuccessState(this.commentlist);
}