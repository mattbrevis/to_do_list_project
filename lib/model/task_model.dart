// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class TaskModel {
  int? idTask;
  String descriptionTask;
  int status;     //-PENDING 1-FINISHED - 2-IN PROGRESS 3-CANCELLED

  TaskModel({
    this.idTask,
    required this.descriptionTask,
    required this.status,   
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idTask': idTask,
      'descriptionTask': descriptionTask,
      'status': status,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      //idTask: map['idTask'] as int,
      descriptionTask: map['descriptionTask'] as String,
      status: map['status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
