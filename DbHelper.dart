import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), "DictionaryEngtoTr.db"),
      version: 1,
      onCreate: (db, version) {
        db.execute("""CREATE TABLE IF NOT EXISTS word(
id INTEGER PRIMARY KEY AUTOINCREMENT,
EngWord TEXT,
TrWord TEXT,
created TEXT
)""");
      },
    );
  }

  static Future<int> addWord({String? EngWord, required String TrWord}) async {
    final db = await DbHelper.db();
    return db.insert("word", {
      "EngWord": EngWord,
      "TrWord": TrWord,
      "created": DateTime.now().toString().split(".")[0],
    });
  }

  static Future<List<Map<String, dynamic>>> getAll() async {
    final db = await DbHelper.db();
    return db.query("word");
  }

  static Future<int> updateInfo(
      {required int id, String? EngWord, String? TrWord}) async {
    final db = await DbHelper.db();
    return db.update("word", {"EngWord": EngWord, "TrWord": TrWord},
        where: "id=?", whereArgs: [id]);
  }

  static Future<int> deleteInfo(int id) async {
    final db = await DbHelper.db();
    return db.delete("word", where: "id=?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> searchWord(
      String searchText) async {
    final db = await DbHelper.db();
    return db.query(
      "word",
      where: "EngWord LIKE ?",
      whereArgs: ['%$searchText%'],
    );
  }
}
