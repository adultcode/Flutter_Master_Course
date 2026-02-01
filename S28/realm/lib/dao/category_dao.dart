import 'package:realm/realm.dart';
import 'package:realm_todo/model/category_model.dart';

class CategoryDAO{

  final config = Configuration.local([CategoryModel.schema]);

  Realm? realm;
  CategoryDAO(){
    realm = Realm(config);
  }

  int GetNextID(){
    var _list = realm?.all<CategoryModel>();
    var count = _list!.length;
    return count++;
  }

  List<CategoryModel> GetAllCategory(){
    var _list = realm?.all<CategoryModel>();
    return _list!.toList();
  }
  bool InsertCategory(CategoryModel categoryModel){
    try{
      var pr_key = GetNextID();
      //categoryModel.id = pr_key;
      realm!.write(() {
        categoryModel.id = pr_key;
        realm!.add(categoryModel);
      },);
      return true;
    } catch(e){
      print("Error: ${e.toString()}");
      return false;
    }
  }


  bool UpdateCategory(CategoryModel categoryModel,String title){
    try{
      realm!.write(() {
        categoryModel.title = title;
        realm!.add(categoryModel);
      },);
      return true;
    } catch(e){
      print("Error: ${e.toString()}");
      return false;
    }
  }

  bool DeleteCategory(CategoryModel categoryModel,){
    try{
      realm!.write(() {
        realm!.delete(categoryModel);
      },);
      return true;
    } catch(e){
      print("Error: ${e.toString()}");
      return false;
    }
  }

}