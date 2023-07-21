import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  ///create table using sql db object
  ///db execute create table
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE MoviesItem(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      posterPath TEXT,
      overview TEXT,
      backdropPath TEXT,
      releaseDate TEXT,
      originalLanguage TEXT,
      originalTitle TEXT,
      imagePath FILE?,
      createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }
}
