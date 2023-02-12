import 'package:flutter/material.dart';
import 'package:to_do_list_project/constants/status_task.dart';
import 'package:to_do_list_project/repository/task_repository.dart';
import 'package:to_do_list_project/views/tasks/new_task_page.dart';

import '../../model/task_model.dart';

class ListTaskPage extends StatefulWidget {
  const ListTaskPage({super.key});

  @override
  State<ListTaskPage> createState() => _ListTaskPageState();
}

class _ListTaskPageState extends State<ListTaskPage> {
  List<TaskModel> listTasks = [];

  void getTasks() async {
    listTasks = await TaskRepository().getAllTasks() ?? [];
    setState(() {});
  }

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your tasks')),
      body: ListView.builder(
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
            return SizedBox(
              width: MediaQuery.of(context).size.width * .75,
              height: 100,
              child: Card(
                shape: const RoundedRectangleBorder(),
                elevation: 8,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskPage(
                                task: listTasks[index],
                              )),
                    );
                  },
                  leading: iconIndexedTask,
                  title: Text(listTasks[index].titleTask.toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge),
                  subtitle: Text(
                      '${listTasks[index].descriptionTask.toString()} \n$statusIndexTask',
                      style: Theme.of(context).textTheme.titleMedium),
                  trailing: const Icon(Icons.edit_note_rounded),
                  isThreeLine: true,
                ),
              ),

              //         Text(statusIndexTask, style: Theme.of(context).textTheme.titleMedium),
            );
          })),
    );
  }
}
