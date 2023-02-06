import 'package:flutter/material.dart';
import 'package:to_do_list_project/views/new_task_page.dart';

import '../model/task_model.dart';
import '../repository/task_repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    TaskRepository().newTask(TaskModel.fromMap({   
    "descriptionTask": "descriptionTask",
    "status": 0
}));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'),),
      body: Container(

      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) => const NewTaskPage())));
      },
      child: const Icon(Icons.add_alert_rounded),
      ),
      
    );
  }
}