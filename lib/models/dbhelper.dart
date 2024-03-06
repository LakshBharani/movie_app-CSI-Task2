import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    // Get the device's directory for storing the database.
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "movie_favorites.db");

    // Open/create the database at a given path
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    // Create tables
    await db.execute(
        "CREATE TABLE FavoriteMovies(id INTEGER PRIMARY KEY, title TEXT, year TEXT)");
  }

  Future<int> saveMovie(Map<String, dynamic> movie) async {
    var dbClient = await db;
    int res = await dbClient.insert("FavoriteMovies", movie);
    return res;
  }

  Future<List<Map<String, dynamic>>> getFavoriteMovies() async {
    var dbClient = await db;
    List<Map<String, dynamic>> list = await dbClient.query("FavoriteMovies");
    return list;
  }

  Future<int> deleteMovie(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete("FavoriteMovies", where: "id = ?", whereArgs: [id]);
  }
}
