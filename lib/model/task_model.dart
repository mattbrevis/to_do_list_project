
class TaskModel {
  int idTask;
  String descriptionTask;
  String status;     //-PENDING 1-FINISHED - 2-IN PROGRESS 3-CANCELLED
  String dateCreation;
  String? dateValidation;
  
  TaskModel({
    required this.idTask,
    required this.descriptionTask,
    required this.status,
    required this.dateCreation,
    this.dateValidation,
  });
  
}
