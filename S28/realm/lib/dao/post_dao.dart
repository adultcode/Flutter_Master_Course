import 'package:realm/realm.dart';
import 'package:realm_todo/model/post_model.dart';

class PostDAO{

  final config = Configuration.local([PostModel.schema]);

  Realm? realm;
  PostDAO(){
    realm = Realm(config);
  }

  int GetNextID(){
    var _list = realm?.all<PostModel>();
    var count = _list!.length;
    return count++;
  }

  List<PostModel> GetAllPost(){
    var _list = realm?.all<PostModel>();
    return _list!.toList();
  }
  List<PostModel> GetPostByCategory(String title){
    var _list = realm?.query<PostModel>("category == \$0", [title]);
    return _list!.toList();
  }


  bool InsertPost(PostModel postModel){
    try{
      var pr_key = GetNextID();
      //categoryModel.id = pr_key;
      realm!.write(() {
        postModel.id = pr_key;
        realm!.add(postModel);
      },);
      return true;
    } catch(e){
      print("Error: ${e.toString()}");
      return false;
    }
  }


  bool UpdatePost(int id,PostModel new_post){

    try{
      realm!.write(() {
        new_post.id = id;
        realm!.add(new_post);
      },);
      return true;
    } catch(e){
      print("Error: ${e.toString()}");
      return false;
    }
  }

  bool DeletePost(PostModel postModel,){
    try{
      realm!.write(() {
        realm!.delete(postModel);
      },);
      return true;
    } catch(e){
      print("Error: ${e.toString()}");
      return false;
    }
  }

}