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
  // Create
  Future<int> insertLelwapa(Lelwapa lelwapa) async {
    Database db = await this.db;
    var res = await db.insert("lelwapa", lelwapa.toMap());
    return res;
  }

  // Read
  Future<List<Lelwapa>> getMalwapa() async {
    Database db = await this.db;
    var res = await db.query("lelwapa");
    List<Lelwapa> list = res.map((e) => Lelwapa.fromObject(e)).toList();
    return list;
  }

  // Update
  Future<int> updateLelwapa(Lelwapa lelwapa) async {
    Database db = await this.db;
    var res = await db.update("lelwapa", lelwapa.toMap(),
        where: "id = ?", whereArgs: [lelwapa.id]);
    return res;
  }

  // Delete
  Future<int> deleteLelwapa(Lelwapa lelwapa) async {
    Database db = await this.db;
    var res = db.delete("lelwapa", where: "id = ?", whereArgs: [lelwapa.id]);
    return res;
  }

  // CRUD for Motho
  // Create
  Future<int> insertMotho(Motho motho) async {
    Database db = await this.db;
    var res = await db.insert("motho", motho.toMap());
    return res;
  }

  // Read
  Future<List<Motho>> getBatho() async {
    Database db = await this.db;
    var res = await db.query("motho");
    List<Motho> list = res.map((e) => Motho.fromObject(e)).toList();
    return list;
  }

  // Update
  Future<int> updateMotho(Motho motho) async {
    Database db = await this.db;
    var res = await db
        .update("motho", motho.toMap(), where: "id = ?", whereArgs: [motho.id]);
    return res;
  }

  // Delete
  Future<int> deleteMotho(Motho motho) async {
    Database db = await this.db;
    var res = await db.delete("motho", where: "id = ?", whereArgs: [motho.id]);
    return res;
  }

  // CRUD for Seruiwa
  // Create
  Future<int> insertSeruiwa(Seruiwa seruiwa) async {
    Database db = await this.db;
    var res = await db.insert("seruiwa", seruiwa.toMap());
    return res;
  }

  // Read
  Future<List<Seruiwa>> getDiruiwa() async {
    Database db = await this.db;
    var res = await db.query("seruiwa");
    List<Seruiwa> list = res.map((e) => Seruiwa.fromObject(e)).toList();
    return list;
  }

  // Update
  Future<int> updateSeruiwa(Seruiwa seruiwa) async {
    Database db = await this.db;
    var res = await db.update("seruiwa", seruiwa.toMap(),
        where: "id = ?", whereArgs: [seruiwa.id]);
    return res;
  }

  // Delete
  Future<int> deleteSeruiwa(Seruiwa seruiwa) async {
    Database db = await this.db;
    var res =
        await db.delete("seruiwa", where: "id = ?", whereArgs: [seruiwa.id]);

    return res;
  }
}
