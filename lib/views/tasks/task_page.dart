// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:to_do_list_project/constants/status_task.dart';
import 'package:to_do_list_project/model/task_model.dart';
import 'package:to_do_list_project/repository/task_repository.dart';
import 'package:intl/intl.dart';

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
  final dateValidityController = TextEditingController();
  bool isSaving = false;
  int i = 0;
  String titleStatusTask = '';
  bool controlValidity = true;
  void newTask(TaskModel taskModel) async {
    await TaskRepository().newTask(taskModel).then((value) {
      if (value > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New task saved!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error saving task.')),
        );
      }
    });
  }

  void editTask(TaskModel taskModel) async {
    taskModel.idTask = widget.task!.idTask;
    await TaskRepository().updateTask(taskModel).then((value) {
      if (value > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task edited!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error saving task.')),
        );
      }
    });
  }

  void loadTask() {
    setState(() {
      if (widget.task != null) {
        titleTaskController.text = widget.task!.titleTask.toUpperCase();
        taskDescriptionController.text =
            widget.task!.descriptionTask.toString();
        titleStatusTask = statusTask[widget.task!.status];
        dateValidityController.text = widget.task!.dateValidity.toString();
        controlValidity =
            (widget.task == null || widget.task?.dateValidity == null)
                ? false
                : true;
      } else {
        titleStatusTask = statusTask.first;
        controlValidity = false;
      }
    });
  }

  void deleteTask(int idTask) async {
    await TaskRepository().deleteTask(idTask).then((value) {
      if (value > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task deleted.')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error deleting task.')),
        );
      }
    });
  }
  @override
  void dispose() {
    dateValidityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    loadTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task page')),
      body: Form(
        key: formKey,
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 30, 0),
          child: ListView(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.scaleDown,
                  image: AssetImage("assets/images/taskico.png"),
                )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.task == null ? 'Create a new task' : 'Edit your task',
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                readOnly: false,
                controller: titleTaskController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 23),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: Text('Title'),
                    floatingLabelStyle: TextStyle(fontSize: 23),
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
                    labelStyle: TextStyle(fontSize: 23),
                    
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
              SizedBox(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(fontSize: 23),
                      label: Text('Status'),
                      border: OutlineInputBorder()),
                  value: titleStatusTask,
                  icon: const Icon(Icons.arrow_downward),
                  alignment: AlignmentDirectional.centerStart,
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
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Switch(
                    value: controlValidity,
                    activeColor: Colors.greenAccent,
                    onChanged: (bool value) {
                      setState(() {
                        controlValidity = value;
                        if (value == false) {
                          dateValidityController.text = '';
                        } else {
                          dateValidityController.text =
                              DateTime.now().toString();
                        }
                      });
                    },
                  ),
                  const Text(
                    'Control Validity?',
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.all(10),
                      child: DateTimePicker(
                        enabled: controlValidity,
                        controller: dateValidityController,
                        dateMask: 'yyyy-MM-dd',
                        type: DateTimePickerType.date,
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2100),
                        onChanged: (val) {},
                        validator: (val) {
                          if (controlValidity == true &&
                              dateValidityController.text.isEmpty) {
                            return 'Date validity is required if you';
                          }
                          return null;
                        },
                        onSaved: (val) {},
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
          visible: widget.task != null,
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Delete task"),
                    content: const Text("Would you like to delete this task?"),
                    actions: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red
                          ),
                        ),
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton(
                        child: const Text("Yes"),
                        onPressed: () {
                          deleteTask(widget.task!.idTask!);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          )),
      bottomNavigationBar: SizedBox(
        width: 200,
        height: 50,
        child: Container(
          margin: const EdgeInsets.fromLTRB(50, 0, 50, 10),
          child: ElevatedButton(
              onPressed: isSaving == true
                  ? null
                  : () async {
                      setState(() {
                        isSaving = true;
                      });
                      if (formKey.currentState!.validate()) {
                        String? dateFormatted;
                        if (controlValidity) {
                          final formatter = DateFormat('yyyy-MM-dd');
                          dateFormatted = formatter.format(
                              DateTime.parse(dateValidityController.text));
                        }

                        final taskModel = TaskModel(
                            titleTask: titleTaskController.text,
                            descriptionTask: taskDescriptionController.text,
                            status: i,
                            dateValidity: dateFormatted);
                        if (widget.task == null) {
                          newTask(taskModel);
                        } else {
                          editTask(taskModel);
                        }
                      }
                      setState(() {
                        isSaving = false;
                      });
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.task == null ? 'New task' : 'Edit Task'),
                  Icon(
                    widget.task == null ? Icons.add : Icons.edit,
                    size: 20,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
