import 'package:flutter/material.dart';

import '../dao/post_dao.dart';
import '../model/post_model.dart';

class PostProvider extends ChangeNotifier{

  List<PostModel> post_list = [];
  PostDAO? postDAO;

  PostProvider(){
    postDAO = PostDAO();
  }

  void GetPostList(){
    post_list = postDAO!.GetAllPost();
    notifyListeners();
  }

  void GetPostCategoryList(String title){
    post_list = postDAO!.GetPostByCategory(title);
    notifyListeners();
  }

  bool InsertPost(PostModel postModel){
    var status = postDAO?.InsertPost(postModel);
    if(status==true){
      GetPostList();
      return true;
    }else return false;

  }
  bool UpdateCategory(PostModel postModel,int id){
    var status = postDAO?.UpdatePost(id,postModel);
    if(status==true){
      GetPostList();
      return true;
    }else return false;

  }

  bool DeletePost(PostModel postModel){
    var status = postDAO?.DeletePost(postModel);
    if(status==true){
      GetPostList();
      return true;
    }else return false;

  }
}