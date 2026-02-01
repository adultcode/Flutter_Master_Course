import 'package:socialmedia/model/post_model.dart';

import '../model/user_model.dart';

abstract class ProfileState{
  const ProfileState();


}
class InitialState extends ProfileState{
  InitialState();
}
class LoadingState extends ProfileState{
  LoadingState();
}
class ErrorState extends ProfileState{
  var data;
  ErrorState(this.data);
}
class SuccessState extends ProfileState{
  List<PostModel> postlist;
  UserModel userModel;
  SuccessState(this.postlist,this.userModel);
}