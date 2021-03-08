import 'dart:async';

import 'package:flutter_sqflite_plays/models/entities.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final _databaseVersion = 1;

  // singleton definer
  static final DBHelper _dbHelper = new DBHelper._internal();

  DBHelper._internal();
  factory DBHelper() {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) _db = await initializeDB();
    return _db;
  }

  Future<Database> initializeDB() async {
    // final config =
    String path = join(await getDatabasesPath(), "motse.db");
    return await openDatabase(
      path,
      onConfigure: _onConfigure,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
                CREATE TABLE lelwapa (
                  id INTEGER PRIMARY KEY autoincrement,
                  surname TEXT NOT NULL,
                  plot INTEGER NOT NULL,
                  housenumber INTEGER NOT NULL,
                  town TEXT NOT NULL
                );
                CREATE TABLE motho (
                  id INTEGER PRIMARY KEY autoincrement,
                  name TEXT NOT NULL,
                  age INTEGER NOT NULL,
                  gender INTENGER NOT NULL,
                  FOREIGN KEY (household) REFERENCES lelwapa(id)
                );
                CREATE TABLE seruiwa (
                  id INTEGER PRIMARY KEY autoincrement,
                  name TEXT NOT NULL,
                  type TEXT NOT NULL,
                  FOREIGN KEY (owner) REFERENCES motho(id)
                );
                CREATE TABLE hobbie (
                  id INTEGER PRIMARY KEY autoincrement,
                  title TEXT NOT NULL
                );
                CREATE TABLE hobbieYaMotho (
                  FOREIGN KEY (motho) REFERENCES motho(id),
                  FOREIGN KEY (hobby) REFERENCES hobbie(id),
                  PRIMARY KEY (motho, hobby)
                );
                ''');
  }

  FutureOr<void> _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  // CRUD for LELWAPA
  // add a new LELWAPA
  Future<int> insertLelwapa(Lelwapa lelwapa) async {
    Database db = await this.db;
    var res = await db.insert('lelwapa', lelwapa.toMap());
    return res;
  }

  // read MALWAPA
  Future<List> getMalwapa() async {
    Database db = await this.db;
    var res = await db.rawQuery("SELECT * FROM lelwapa");
    return res;
  }

  // update LELWAPA
  Future<int> updateLelwapa(Lelwapa lelwapa) async {
    Database db = await this.db;
    var res = await db.update('lelwapa', lelwapa.toMap(),
        where: "id = ?", whereArgs: [lelwapa.id]);
    return res;
  }

  // delete LELWAPA
  Future<int> deleteLelwapa(Lelwapa lelwapa) async {
    Database db = await this.db;
    var res =
        await db.rawDelete('delete from lelwapa where id = ${lelwapa.id}');
    return res;
  }

  // CRUD for Motho
}
