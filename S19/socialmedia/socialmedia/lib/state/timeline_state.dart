import 'package:socialmedia/model/post_model.dart';

import '../model/user_model.dart';

abstract class TimelineState{
  const TimelineState();


}
class InitialState extends TimelineState{
  InitialState();
}
class LoadingState extends TimelineState{
  LoadingState();
}
class ErrorState extends TimelineState{
  var data;
  ErrorState(this.data);
}
class SuccessState extends TimelineState{
  List<PostModel> postlist;
  SuccessState(this.postlist);
}