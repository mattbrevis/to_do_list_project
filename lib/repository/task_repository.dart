// ignore_for_file: constant_identifier_names
import 'package:to_do_list_project/provider/database_provider.dart';
import 'package:to_do_list_project/repository/task_interface.dart';
import '../model/task_model.dart';

class TaskRepository implements ITaskRepository {
  static final TaskRepository _instance = TaskRepository._();
  TaskRepository._();
  factory TaskRepository() => _instance;
  static const TASK_TABLE_NAME = "task";
  static const CREATE_TABLE_TASK = '''
    CREATE TABLE IF NOT EXISTS $TASK_TABLE_NAME 
    (
      idTask INTEGER PRIMARY KEY,
      titleTask TEXT,
      descriptionTask TEXT,
      status INTEGER
    )
  ''';

  @override
  Future<int> deleteTask(int id) async {
    final db = await DatabaseProvider.internal().database;
    var res = await db?.delete(TASK_TABLE_NAME, where: "idTask = ?", whereArgs: [id]);
    return res?? 0;
  }

  @override
  Future<List<TaskModel>?> getAllTasks() async {
    final db = await DatabaseProvider.internal().database;
    var res = await db?.rawQuery('SELECT * FROM $TASK_TABLE_NAME');
    return res?.map((e) => TaskModel.fromMap(e)).toList();
  }

  @override
  Future<List<TaskModel>?> getTask(int id, int status) async {
    final db = await DatabaseProvider.internal().database;
    var res = await db?.rawQuery(
        'SELECT * FROM $TASK_TABLE_NAME WHERE idTask LIKE $id AND status LIKE $status');
    return res?.map((e) => TaskModel.fromMap(e)).toList();
  }

  @override
  Future<int> newTask(TaskModel taskModel) async {
    final db = await DatabaseProvider.internal().database;
    var res = await db?.insert(TASK_TABLE_NAME, taskModel.newTasktoMap());
    return res??0;
  }

  @override
  Future<int> updateTask(TaskModel taskModel) async {
    final db = await DatabaseProvider.internal().database;
    var res = await db?.update(TASK_TABLE_NAME, taskModel.toMap(),
        where: "idTask = ?", whereArgs: [taskModel.idTask]);
    return res??0;
  }
}
