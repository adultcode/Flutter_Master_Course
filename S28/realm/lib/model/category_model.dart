

import 'package:realm/realm.dart';
part 'category_model.g.dart';
@RealmModel()
class _CategoryModel{
  @PrimaryKey()
  int? id;

  String? title;

}