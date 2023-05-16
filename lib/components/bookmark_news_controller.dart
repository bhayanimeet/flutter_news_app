import 'package:flutter/cupertino.dart';
import 'package:flutter_news_app/models/bookmark_news_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper extends ChangeNotifier{
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();

  Database? db;

  static const tableName = "News";
  static const id = "id";
  static const title = "title";
  static const description = "description";
  static const image = "image";
  static const url = "url";

  Future<void> dataTable() async {
    String directory = await getDatabasesPath();
    String path = join(directory, "demo.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String query = "CREATE TABLE IF NOT EXISTS $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT,$title TEXT,$description TEXT,$image BLOB,$url TEXT)";
        await db.execute(query);
      },
    );
    notifyListeners();
  }

  Future<int> insertData({required BookMarkNews data}) async {
    await dataTable();

    String query = "INSERT INTO $tableName($title,$description,$image,$url) VALUES(?,?,?,?)";
    List args = [data.title,data.description,data.image,data.url];

    int res = await db!.rawInsert(query, args);

    notifyListeners();

    return res;
  }

  Future<List<BookMarkNews>> selectData() async {
    await dataTable();

    String query = "SELECT * FROM $tableName;";

    List<Map<String, dynamic>> allNews = await db!.rawQuery(query);

    List<BookMarkNews> news = allNews.map((e) => BookMarkNews.fromMap(data: e)).toList();

    notifyListeners();

    return news;
  }

  Future<int> deleteData({required int index}) async {
    await dataTable();

    String query = "DELETE FROM $tableName WHERE $id=?;";

    int res = await db!.rawDelete(query, [index]);

    notifyListeners();

    return res;
  }
}