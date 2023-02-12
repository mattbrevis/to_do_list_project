// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  int? idTask;
  String descriptionTask;
  int status; //-PENDING 1-FINISHED - 2-IN PROGRESS

  TaskModel({
    this.idTask,
    required this.descriptionTask,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'idTask': idTask,
      'descriptionTask': descriptionTask,
      'status': status,
    };
  }

  Map<String, dynamic> newTasktoMap() {
    return {
      'descriptionTask': descriptionTask,
      'status': status,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      idTask: map['idTask'],
      descriptionTask: map['descriptionTask'],
      status: map['status'],
    );
  }
}
