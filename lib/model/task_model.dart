// ignore_for_file: public_member_api_docs, sort_constructors_first

class TaskModel {
  int? idTask;
   String titleTask;
  String descriptionTask;
  int status; //-PENDING 1-FINISHED - 2-IN PROGRESS
  String? dateValidity;

  TaskModel({
    this.idTask,
    required this.titleTask,
    required this.descriptionTask,
    required this.status,
    this.dateValidity,
  });

  Map<String, dynamic> tasktoMap() {
    return {
      'titleTask': titleTask,
      'descriptionTask': descriptionTask,
      'status': status,
      'dateValidity': dateValidity
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      idTask: map['idTask'],
      descriptionTask: map['descriptionTask'],
      titleTask: map['titleTask'],
      status: map['status'],
      dateValidity: map['dateValidity']
    );
  }
}
