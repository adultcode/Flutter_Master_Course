import 'package:flutter/cupertino.dart';
import 'package:realm_todo/dao/category_dao.dart';

import '../model/category_model.dart';

class CategoryProvider extends ChangeNotifier{

  List<CategoryModel>? cat_list = [];
  CategoryDAO? categoryDAO;

  CategoryProvider(){
    categoryDAO = CategoryDAO();
  }

  void GetCategoryList(){
    cat_list = categoryDAO?.GetAllCategory();
    notifyListeners();
  }

  bool InsertCategory(CategoryModel categoryModel){
    var status = categoryDAO?.InsertCategory(categoryModel);
    if(status==true){
      GetCategoryList();
      return true;
    }else return false;

  }
  bool UpdateCategory(CategoryModel categoryModel,String title){
    var status = categoryDAO?.UpdateCategory(categoryModel,title);
    if(status==true){
      GetCategoryList();
      return true;
    }else return false;

  }

  bool DeleteCategory(CategoryModel categoryModel){
    var status = categoryDAO?.DeleteCategory(categoryModel);
    if(status==true){
      GetCategoryList();
      return true;
    }else return false;

  }
}