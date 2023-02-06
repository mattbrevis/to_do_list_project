// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:to_do_list_project/provider/database_provider.dart';

import '../model/task_model.dart';

class TaskRepository {
  static final TaskRepository _instance = TaskRepository._();
  TaskRepository._();
  factory TaskRepository() => _instance;
  static const TASK_TABLE_NAME = "task";
  static const CREATE_TABLE_TASK = '''
    CREATE TABLE IF NOT EXISTS $TASK_TABLE_NAME 
    (
      idTask INTEGER PRIMARY KEY,
      descriptionTask TEXT,
      status INTEGER
    )
  ''';

  newTask(TaskModel taskModel) async {
    final db = await DatabaseProvider.internal().database;
    var res = await db?.insert(TASK_TABLE_NAME, taskModel.toMap());
    if (kDebugMode) {
      print(res);
    }
    return res;
  }

  deleteTask(int id) async {
    final db = await DatabaseProvider.internal().database;
    var res = db?.delete(TASK_TABLE_NAME, where: "idTask = ?", whereArgs: [id]);
    return res;
  }

  deleteAll() async {
    final db = await DatabaseProvider.internal().database;
    db?.rawDelete("Delete * from $TASK_TABLE_NAME");
  }

  updateClient(TaskModel taskModel) async {
    final db = await DatabaseProvider.internal().database;
    var res = await db?.update(TASK_TABLE_NAME, taskModel.toMap(),
        where: "idTask = ?", whereArgs: [taskModel.idTask]);
    return res;
  }
}
