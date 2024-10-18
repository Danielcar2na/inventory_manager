import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class SqliteService {
  String dbName = 'DataBase.db';

  Future<Database> openDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, dbName);
    Database db;

    //verifica si existe la base de datos en la carpeta raiz
    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      //copia la base de datos de la carepa assets a la carpeta raiz
      ByteData data = await rootBundle.load(join("assets", dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }
    db = await openDatabase(path);
    return db;
  }

  Future closeDB(Database db) async {
    await db.close();
  }
}
