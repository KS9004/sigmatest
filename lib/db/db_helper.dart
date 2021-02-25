import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sigma_test/model/sigmat.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
// if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "sigma.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE Sigma (id INTEGER ,displayName TEXT,meta TEXT,description TEXT,v INTEGER,)');
        });
  }

  Future<void> insertSigmaData(SigmaModel tag) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Tag into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'sigma',
      tag.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SigmaModel>> readSigmaData() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The SigmaData.
    final List<Map<String, dynamic>> maps = await db.query('sigma');

    // Convert the List<Map<String, dynamic> into a List<Tag>.
    return List.generate(maps.length, (i) {
      return SigmaModel(
        id: maps[i]['id'],
        displayName: maps[i]['displayName'],
        meta: maps[i]['meta'],
        description: maps[i]['description'],
        v: maps[i]['v']
      );
    });
  }

}

