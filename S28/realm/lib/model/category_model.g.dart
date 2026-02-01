// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class CategoryModel extends _CategoryModel
    with RealmEntity, RealmObjectBase, RealmObject {
  CategoryModel(
    int? id, {
    String? title,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
  }

  CategoryModel._();

  @override
  int? get id => RealmObjectBase.get<int>(this, 'id') as int?;
  @override
  set id(int? value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get title => RealmObjectBase.get<String>(this, 'title') as String?;
  @override
  set title(String? value) => RealmObjectBase.set(this, 'title', value);

  @override
  Stream<RealmObjectChanges<CategoryModel>> get changes =>
      RealmObjectBase.getChanges<CategoryModel>(this);

  @override
  CategoryModel freeze() => RealmObjectBase.freezeObject<CategoryModel>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(CategoryModel._);
    return const SchemaObject(
        ObjectType.realmObject, CategoryModel, 'CategoryModel', [
      SchemaProperty('id', RealmPropertyType.int,
          optional: true, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string, optional: true),
    ]);
  }
}
