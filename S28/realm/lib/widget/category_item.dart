import 'package:flutter/material.dart';
import 'package:realm_todo/model/category_model.dart';
import 'package:realm_todo/util/my_color.dart';

class CategoryItem extends StatelessWidget {

  CategoryModel categoryModel;
  bool selected;

  CategoryItem(this.categoryModel, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 6),
      constraints: BoxConstraints(
        maxWidth: 80
      ),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: MyColor.main_color),
        borderRadius: BorderRadius.all(Radius.circular(25)),
          color: selected==false? Colors.white : MyColor.main_color
      ),
      child: Text(categoryModel.title!,
      style: TextStyle(color: selected==false?MyColor.main_color:Colors.white),
      ),
    );
  }
}
