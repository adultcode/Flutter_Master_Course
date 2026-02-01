import 'package:socialmedia/model/user_model.dart';

class CommentModel{

  int? id;
  String? content;
  UserModel? user_set;

  CommentModel({this.id, this.content, this.user_set});

  CommentModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    content = json['content'];
    user_set = UserModel.fromJson(json['user_set']);
  }
}