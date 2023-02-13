import 'package:flutter/material.dart';
import 'package:to_do_list_project/constants/status_task.dart';
import 'package:to_do_list_project/repository/task_repository.dart';
import 'package:to_do_list_project/views/tasks/task_page.dart';

import '../../model/task_model.dart';

class ListTaskPage extends StatefulWidget {
  const ListTaskPage({super.key});

  @override
  State<ListTaskPage> createState() => _ListTaskPageState();
}

class _ListTaskPageState extends State<ListTaskPage> {
  List<TaskModel> listTasks = [];
  bool isLoading = true;

  void getTasks() async {
    isLoading = true;
    listTasks=[];
    listTasks = await TaskRepository().getAllTasks() ?? [];
    setState(() {
      isLoading=false;
    });
  }

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your personal tasks')),
      body:isLoading==true? const Center(child: CircularProgressIndicator(),) : ListView.builder(
          itemCount: listTasks.length,
          itemBuilder: ((context, index) {
            String statusIndexTask = '';
            Icon iconIndexedTask = const Icon(Icons.alarm);
            switch (listTasks[index].status) {
              case 0:
                statusIndexTask = statusTask[0];
                iconIndexedTask = const Icon(Icons.pending_actions_rounded,
                    color: Colors.red, size: 50);
                break;
              case 1:
                statusIndexTask = statusTask[1];
                iconIndexedTask = const Icon(Icons.task_rounded,
                    color: Colors.green, size: 50);
                break;
              case 2:
                statusIndexTask = statusTask[2];
                iconIndexedTask = const Icon(Icons.run_circle_outlined,
                    color: Colors.orange, size: 50);
                break;
            }
            return Card(
              shape: const RoundedRectangleBorder(),
              elevation: 8,
              child: ListTile(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TaskPage(
                              task: listTasks[index],
                            )),
                  );
                  getTasks();

                },
                leading: iconIndexedTask,
                title: Text(listTasks[index].titleTask.toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge),
                subtitle: Text(
                    '${listTasks[index].descriptionTask.toString()} \nSTATUS: $statusIndexTask',
                    style: Theme.of(context).textTheme.titleMedium),
                trailing: const Icon(Icons.edit_note_rounded),
                isThreeLine: true,
              ),
            );
          })),
    );
  }
}
