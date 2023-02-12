// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:to_do_list_project/constants/status_task.dart';
import 'package:to_do_list_project/model/task_model.dart';
import 'package:to_do_list_project/repository/task_repository.dart';

class TaskPage extends StatefulWidget {
  final TaskModel? task;
  const TaskPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final formKey = GlobalKey<FormState>();
  final taskDescriptionController = TextEditingController();
  final titleTaskController = TextEditingController();
  bool isSaving = false;
  int i = 0;
  String titleStatusTask = '';
  
  void newTask(TaskModel taskModel) async {
    await TaskRepository().newTask(taskModel).then((value) {
      if (value > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New task saved!')),
        );
        Navigator.pop(context);
      }
    });
  }

  void editTask(TaskModel taskModel) async{
    await TaskRepository().updateTask(taskModel).then((value) {
      if (value > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New task saved!')),
        );
        Navigator.pop(context);
      }
    });
  }

  void loadTask(){
    if(widget.task != null){
      titleTaskController.text = widget.task!.titleTask.toUpperCase();
      taskDescriptionController.text = widget.task!.descriptionTask.toString();
      titleStatusTask = statusTask[widget.task!.status];
    }else{
      titleStatusTask = statusTask.first;
    }   
  }

  @override
  void initState() {
    
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  readOnly: false,
                  controller: titleTaskController,
                  decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Title',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      )),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  maxLines: 5,
                  readOnly: false,
                  controller: taskDescriptionController,
                  decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      )),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      label: Text('Status'), border: OutlineInputBorder()),
                  value: titleStatusTask,
                  
                  icon: const Icon(Icons.arrow_downward),
                  onChanged: (String? value) {
                    setState(() {
                      titleStatusTask = value!;
                      if (value == statusTask[0]) {
                        i = 0;
                      } else if (value == statusTask[1]) {
                        i = 1;
                      } else {
                        i = 2;
                      }
                    });
                  },
                  items:
                      statusTask.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 25,
                ),
                Visibility(
                  visible: false, //todo later
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: DateTimePicker(
                        decoration: const InputDecoration(
                            label: Text('Validity'),
                            border: OutlineInputBorder()),
                        initialValue: DateTime.now().toString(),
                        type: DateTimePickerType.date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        onChanged: (val) {},
                        validator: (val) {
                          return null;
                        },
                        onSaved: (val) {},
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(title: const Text('Nova Task',)),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width * .85,
        height: 50,
        child: ElevatedButton(onPressed: isSaving == true
                ? null
                : () async {
                    setState(() {
                      isSaving = true;
                    });
                    if (formKey.currentState!.validate()) {
                      final taskModel = TaskModel(
                          titleTask: titleTaskController.text,
                          descriptionTask: taskDescriptionController.text,
                          status: i);
                      newTask(taskModel);
                    }
                    setState(() {
                      isSaving = false;
                    });
                  }, child: const Text('Nova task')),
      ),
     
    );
  }
}