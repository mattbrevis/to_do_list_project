import '../model/task_model.dart';

abstract class ITaskRepository{
  Future<List<TaskModel>?> getAllTasks();
  Future<List<TaskModel>?> getTask(int id, int status);
  Future<int?> newTask(TaskModel taskModel);
  Future<int?> deleteTask(int id);
  Future<int?> updateTask(TaskModel taskModel);

}