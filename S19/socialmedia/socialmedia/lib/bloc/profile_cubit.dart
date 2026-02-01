import 'package:bloc/bloc.dart';
import 'package:socialmedia/model/post_model.dart';
import 'package:socialmedia/model/user_model.dart';
import 'package:socialmedia/repository/profile_repository.dart';

import '../state/profile_state.dart';


class ProfileCubit  extends Cubit<ProfileState>{

  ProfileCubit() : super(InitialState());

  ProfileRepository? _profileRepository;

  void SendRequest(var data)async{

    emit(LoadingState());
    _profileRepository = ProfileRepository();
    var result =await _profileRepository?.ProfileRequest(data);

    if(result?.status==200){

      UserModel _usermodel = UserModel.fromJson(result?.data['user'][0]);
      Iterable _list = result?.data["user"][0]['post'];
      List<PostModel> _postlist =
      _list.map((e) => PostModel.fromJson(e)).toList();

      emit(SuccessState(_postlist,_usermodel));


    }else{
      emit(ErrorState(result?.data));
    }
  }

}