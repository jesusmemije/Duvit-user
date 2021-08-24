import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:duvit/models/check_task_model.dart';
export 'package:duvit/models/check_task_model.dart';

class DBProvider {

  // Temporal leer base de datos
  //final tempCheckTask = new CheckTaskModel(idPlaneacion: 12, idUser: 1, status: 'comenzar');
  //DBProvider.db.newCheckTask(tempCheckTask);
  //DBProvider.db.getCheckTaskById(5).then((checkTask) => print("Memije: " + checkTask!.status));

  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async => _database ??= await initDatabase();

  Future<Database> initDatabase() async {
    //Path de donde almacenamos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'CheckTasksDB.db');
    print(path);

    //Crear base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE CheckTasks (
            id INTEGER PRIMARY KEY,
            idUser INTEGER,
            idPlaneacion INTEGER,
            status TEXT
          )
        ''');
    });
  }

  Future<int> newCheckTaskRaw(CheckTaskModel newCheckTask) async {
    final id = newCheckTask.id;
    final idPlaneacion = newCheckTask.idPlaneacion;
    final idUser = newCheckTask.idUser;
    final status = newCheckTask.status;

    // Verificar la base de datos
    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO CheckTasks( id, idUser, idPlaneacion, status)
        VALUES( $id, $idPlaneacion, $idUser, '$status' )
    ''');

    return res;
  }

  Future<int> newCheckTask(CheckTaskModel newCheckTask) async {
    final db = await database;
    final res = await db.insert('CheckTasks', newCheckTask.toJson());

    print('Memije: ' + res.toString());

    return res;
  }

  Future<CheckTaskModel> getCheckTaskById(int id) async {
    final db = await database;
    final res = await db.query('CheckTasks', where: 'id = ?', whereArgs: [id]);

    final tempCheckTask = new CheckTaskModel(idPlaneacion: 0, idUser: 0, status: '');

    return res.isNotEmpty ? CheckTaskModel.fromJson(res.first) : tempCheckTask;
  }

  Future<CheckTaskModel> getCheckTaskByIdPlaneacion(int idPlaneacion) async {
    final db = await database;
    final res = await db.query('CheckTasks', where: 'idPlaneacion = ?', whereArgs: [idPlaneacion]);

    final tempCheckTask = new CheckTaskModel(idPlaneacion: 0, idUser: 0, status: '');
    return res.isNotEmpty ? CheckTaskModel.fromJson(res.first) : tempCheckTask;
  }

  Future<List<CheckTaskModel>> getAllCheckTasks() async {
    final db = await database;
    final res = await db.query('CheckTasks');

    return res.isNotEmpty
        ? res.map((checkTask) => CheckTaskModel.fromJson(checkTask)).toList()
        : [];
  }

  Future<List<CheckTaskModel>> getCheckTasksByStatus(String status) async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM CheckTasks WHERE status = '$status'
    ''');

    return res.isNotEmpty
        ? res.map((checkTask) => CheckTaskModel.fromJson(checkTask)).toList()
        : [];
  }

  Future<int> updateCheckTask( CheckTaskModel updateCheckTask ) async {
    final db  = await database;
    final res = await db.update('CheckTasks', updateCheckTask.toJson(), where: 'id = ?', whereArgs: [updateCheckTask.id]);
    return res;
  }

  Future<int> deleteCheckTaskById( int id ) async {
    final db  = await database;
    final res = await db.delete('CheckTasks', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllCheckTasks() async {
    final db  = await database;
    final res = await db.delete('CheckTasks');
    return res;
  }

}
