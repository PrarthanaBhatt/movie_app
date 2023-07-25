import 'package:flutter/foundation.dart';
import 'package:movie_app/src/utils/helpers/register_sql_helper.dart';
import 'package:sqflite/sqflite.dart' as sql;

class LoginSQLHelper {
  ///create table using sql db object
  ///db execute create table
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE login_items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      mobileNo INTEGER,
      password TEXT,
      createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  //below method calls create table method
  //every time when add item or any operation performed on item that time
  //first it will check that db is created or not then if table is created or not
  //if its not then creates first time
  //if its created it shares the db object which helps to connect with the table
  static Future<sql.Database> db() async {
    return sql.openDatabase('logindb.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      print("...Login Table Created..");
      await createTables(database);
    });
  }

// from add button pressed
  static Future<int> createItem(String mobileNo, String password) async {
    final db = await LoginSQLHelper.db();
    //put data in map format
    final data = {'mobileNo': mobileNo, 'password': password};
    //db insert in table with map format
    //conflict algorithm removes duplicate entry
    //item is table name, data is new record
    //id -- if record is added successfully then gives row id
    final id = await db.insert('login_items', data);
    return id;
  }

  //when launch or reload app
  //get all movie_items from DB
  // db.query when you want to get an item
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await LoginSQLHelper.db();
    return db.query('login_items', orderBy: "id");
  }

  //for getting single record based on ID
  //whereArgs: [id] for getting from certain ID
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await LoginSQLHelper.db();
    return db.query('login_items', where: "id = ?", whereArgs: [id], limit: 1);
  }
}
