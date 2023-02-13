import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:to_do_list_project/repository/task_repository.dart';

class DatabaseProvider {
  DatabaseProvider.internal();
  static final DatabaseProvider _instance = DatabaseProvider.internal();  
  factory DatabaseProvider() => _instance;
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;    
  }

  // static DatabaseProvider get() {
  //   return _instance;
  // }



  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();        
    String path = join(documentsDirectory.path, "todolist.db");
    var ourDB = await openDatabase(
      path,      
      version: 1,
      onCreate: _onCreate,
      onOpen: _onOpen,
    );

    return ourDB;
  }

  
_onCreate(Database db, int version) async{
  await db.execute(TaskRepository.CREATE_TABLE_TASK);
  
}
 void _onOpen(Database db) async {}
  


}
