import 'package:socialmedia/model/user_model.dart';

class PostModel{

  String? id;
  String? content;
  String? image;
  bool? is_liked;
  int? comment_count;
  int? like_count;
  UserModel? user_set;

  PostModel({this.id, this.content, this.image, this.is_liked,
      this.comment_count, this.like_count, this.user_set});


  PostModel.fromJson(Map<String, dynamic> json){

    id = json['id'];
    content = json['content'];
    image = json['image'];
    is_liked = json['is_Liked'];
    comment_count = json['comment_count'];
    like_count = json['like_count'];
    user_set = UserModel.fromJson(json['user_set']);

  }

}