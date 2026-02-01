import '../model/user_model.dart';

abstract class LikePostState{
  const LikePostState();
/*
  1: initial state
  2: loading state
  3: Eror state
  4: Successful state
   */

}
class InitialState extends LikePostState{
  InitialState();
}
class LoadingState extends LikePostState{
  LoadingState();
}
class ErrorState extends LikePostState{
  var data;
  ErrorState(this.data);
}
class LikedState extends LikePostState{
  String data;
  LikedState(this.data);
}
class UnLikedState extends LikePostState{
  String data;
  UnLikedState(this.data);
}