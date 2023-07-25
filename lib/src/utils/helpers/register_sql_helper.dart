import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class RegisterSQLHelper {
  ///create table using sql db object
  ///db execute create table
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE user_registration_items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      email TEXT,
      dob TEXT,
      gender TEXT,
      state TEXT,
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
    return sql.openDatabase('registrationdb.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      print("...Register Table Created..");
      await createTables(database);
    });
  }

// from add button pressed
  static Future<int> createItem(String name, String email, String dob,
      String gender, String state, String mobileNo, String password) async {
    final db = await RegisterSQLHelper.db();
    //put data in map format
    final data = {
      'name': name,
      'email': email,
      'dob': dob,
      'gender': gender,
      'state': state,
      'mobileNo': mobileNo,
      'password': password
    };
    //db insert in table with map format
    //conflict algorithm removes duplicate entry
    //item is table name, data is new record
    //id -- if record is added successfully then gives row id
    final id = await db.insert('user_registration_items', data);
    return id;
  }

  //when launch or reload app
  //get all movie_items from DB
  // db.query when you want to get an item
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await RegisterSQLHelper.db();
    return db.query('user_registration_items', orderBy: "id");
  }

  //for getting single record based on ID
  //whereArgs: [id] for getting from certain ID
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await RegisterSQLHelper.db();
    return db.query('user_registration_items',
        where: "id = ?", whereArgs: [id], limit: 1);
  }
}
