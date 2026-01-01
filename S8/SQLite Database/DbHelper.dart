import 'package:path/path.dart';
import 'package:season/phone.dart';
import 'package:sqflite/sqflite.dart';
class DBHelper{

  String tbl_name = "phone_tbl";

  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path,'Mydb.db'),
      version: 1,
      onCreate: (database,version) async{
        await database.execute(

          "CREATE TABLE $tbl_name (id INTEGER PRIMARY KEY AUTOINCREMENT"
              ",name TEXT NOT NULL, number INTEGER NOT NULL)"
        );
      }

    );
  }


  Future<int?> CreateItem(Phone phone) async{
    final Database db = await initializeDB();
    final id = await db.insert(tbl_name, phone.toMap());
    print("id : $id");

  }

  Future<List<Phone>> GetData()async{
    final Database db = await initializeDB();
    final  List<Map<String, Object?>> result = await db.query(tbl_name);
    return result.map((e) => Phone.fromMap(e)).toList();
  }

  Future<void> DeleteItem(int id)async{
    final Database db = await initializeDB();
    var res = await db.delete(tbl_name, where: "id = ?",whereArgs: [id]);
    print("Deleted: $id");
  }

  Future<int?> UpdateItem(Phone phone) async{
    final Database db = await initializeDB();
    final id = await db.update(tbl_name, phone.toMap());
    print("id : $id");

  }
}