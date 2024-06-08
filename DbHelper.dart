import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), "DictionaryEngtoTrNew.db"),
      version: 1,
      onCreate: (db, version) {
        db.execute("""CREATE TABLE IF NOT EXISTS word(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          EngWord TEXT,
          TrWord TEXT,
          created TEXT,
          imagePath TEXT
        )""");
      },
    );
  }

  static Future<int> addWord(
      {String? EngWord, required String TrWord, String? imagePath}) async {
    final db = await DbHelper.db();
    return db.insert("word", {
      "EngWord": EngWord,
      "TrWord": TrWord,
      "created": DateTime.now().toString().split(".")[0],
      "imagePath": imagePath ?? 'lib/Dbimages/',
    });
  }

  static Future<List<Map<String, dynamic>>> getAll() async {
    final db = await DbHelper.db();
    return db.query("word");
  }

  static Future<int> updateInfo(
      {required int id,
      String? EngWord,
      String? TrWord,
      String? imagePath}) async {
    final db = await DbHelper.db();
    Map<String, dynamic> row = {};
    if (EngWord != null) row['EngWord'] = EngWord;
    if (TrWord != null) row['TrWord'] = TrWord;
    if (imagePath != null) row['imagePath'] = imagePath;
    return db.update("word", row, where: "id=?", whereArgs: [id]);
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
