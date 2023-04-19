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
  String titleStatusTask = 'ALL TASKS';
  int i=3;
  void getTasks() async {    
    loadPage();
    listTasks = await TaskRepository().getAllTasks() ?? [];
    setState(() {
      isLoading = false;
    });
  }

  void getSelectedTasks() async {
    loadPage();

    listTasks = await TaskRepository().getTask(status: i==3? null: i) ?? [];
    setState(() {
      isLoading = false;
    });
  }

  void loadPage() {
    setState(() {
      isLoading = true;
      listTasks = [];
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
      appBar: AppBar(title: const Text('List Task')),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              primary: true,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .20,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage("assets/images/checklist.png"),
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: 200,
                        child: DropdownButtonFormField<int>(
                          
                          decoration: const InputDecoration(
                            
                              labelStyle: TextStyle(fontSize: 18),
                              label: Text('Status'),
                              floatingLabelBehavior: FloatingLabelBehavior.always,

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                
                              )),
                          value: i,
                          icon: const Icon(Icons.arrow_downward),
                          alignment: AlignmentDirectional.centerStart,
                          onChanged: (value) {
                            setState(() {
                              if (value == 0) {
                                titleStatusTask = statusTask[0];
                                i = 0;
                              } else if (value == 1) {
                                titleStatusTask = statusTask[1];
                                i = 1;
                              } else if (value == 2) {
                                i = 2;
                              } else {
                                titleStatusTask = 'ALL TASKS';
                                i = 3;
                              }
                            });
                            getSelectedTasks();
                          },
                          items: [
                            const DropdownMenuItem<int>(
                              value: 3,
                              child: Text('ALL TASKS'),
                            ),
                            DropdownMenuItem<int>(
                              value: 0,
                              child: Text(statusTask[0]),
                            ),
                            DropdownMenuItem<int>(
                              value: 1,
                              child: Text(statusTask[1]),
                            ),
                            DropdownMenuItem<int>(
                              value: 2,
                              child: Text(statusTask[2]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: listTasks.isEmpty,
                        child: const Center(
                          child: Text(
                            'No tasks recorded yet.',
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                    Visibility(
                      visible: listTasks.isNotEmpty,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: listTasks.length,
                          itemBuilder: ((context, index) {
                            String statusIndexTask = '';
                            Icon iconIndexedTask = const Icon(Icons.alarm);
                            switch (listTasks[index].status) {
                              case 0:
                                statusIndexTask = statusTask[0];
                                iconIndexedTask = const Icon(
                                    Icons.pending_outlined,
                                    color: Colors.red,
                                    size: 40);
                                break;
                              case 1:
                                statusIndexTask = statusTask[1];
                                iconIndexedTask = const Icon(Icons.task_rounded,
                                    color: Colors.green, size: 50);
                                break;
                              case 2:
                                statusIndexTask = statusTask[2];
                                iconIndexedTask = const Icon(
                                    Icons.work_history_rounded,
                                    color: Colors.orange,
                                    size: 50);
                                break;
                            }
                            String dtValidity = listTasks[index].dateValidity ==
                                    null
                                ? ''
                                : 'Date Validity: ${listTasks[index].dateValidity.toString()}';
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              elevation: 10,
                              child: Container(                                
                                padding: const EdgeInsets.all(10),
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
                                  title: Text(
                                      'TITLE: ${listTasks[index].titleTask.toUpperCase()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                  subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            listTasks[index]
                                                .descriptionTask
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        Text(
                                            'STATUS: $statusIndexTask\n$dtValidity')
                                      ]),
                                  trailing: const Icon(Icons.edit_note_rounded),
                                  isThreeLine: true,
                                ),
                              ),
                            );
                          })),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
