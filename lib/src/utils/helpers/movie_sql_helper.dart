import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class MovieSQLHelper {
  ///create table using sql db object
  ///db execute create table
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE movie_items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      posterPath TEXT,
      createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  //below method calls create table method
  //every time when add item or any operation performed on item that time
  //first it will check that db is created or not then if table is created or not
  //if its not then creates first time
  //if its created it shares the db object which helps to connect with the table
  static Future<sql.Database> db() async {
    return sql.openDatabase('moviedb.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      print("...Table Created..");
      await createTables(database);
    });
  }

// from add button pressed
  static Future<int> createItem(String title, String? posterPath) async {
    final db = await MovieSQLHelper.db();

    //put data in map format
    final data = {'title': title, 'posterPath': posterPath};
    //db insert in table with map format
    //conflict algorithm removes duplicate entry
    //item is table name, data is new record
    //id -- if record is added successfully then gives row id
    final id = await db.insert('movie_items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  //when launch or reload app
  //get all movie_items from DB
  // db.query when you want to get an item
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await MovieSQLHelper.db();
    return db.query('movie_items', orderBy: "id");
  }

  //for getting single record based on ID
  //whereArgs: [id] for getting from certain ID
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await MovieSQLHelper.db();
    return db.query('movie_items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  //for updating certain item
  //whereArgs -> id is id which we passed from update item
  static Future<int> updateItem(
      int id, String title, String? posterPath) async {
    final db = await MovieSQLHelper.db();

    final data = {
      'title': title,
      'posterPath': posterPath,
      'createAt': DateTime.now().toString()
    };

    final result =
        await db.update('movie_items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  //delete perticular item
  static Future<void> deleteItem(int id) async {
    final db = await MovieSQLHelper.db();
    try {
      await db.delete("movie_items", where: "id = ? ", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
