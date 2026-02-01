import '../model/user_model.dart';

abstract class LoginState{
  const LoginState();
  /*
  1: initial state
  2: loading state
  3: Eror state
  4: Successful state
   */

}
class InitialState extends LoginState{
  InitialState();
}
class LoadingState extends LoginState{
  LoadingState();
}
class ErrorState extends LoginState{
  var data;
  ErrorState(this.data);
}
class SuccessState extends LoginState{
  UserModel data;
  SuccessState(this.data);
}