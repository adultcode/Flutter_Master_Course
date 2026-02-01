import 'package:realm/realm.dart';
part 'post_model.g.dart';
@RealmModel()
class _PostModel{
  @PrimaryKey()
  int? id;

  String? title;
  String? content;
  String? category;
  String? date;

}