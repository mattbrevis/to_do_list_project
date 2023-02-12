import 'package:flutter/material.dart';
import 'package:to_do_list_project/views/tasks/new_task_page.dart';
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 120,
                  child: ElevatedButton(
                    onPressed: (() {}),
                    child: const Text('PENDING TASKS'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 120,
                  child: ElevatedButton(
                    onPressed: (() {}),
                    child: const Text('FINISHED TASKS'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 120,
                  child: ElevatedButton(
                    onPressed: (() {}),
                    child: const Text('IN PROGRESS TASKS'),
                  ),
                ),
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const NewTaskPage())));
        },
        child: const Icon(Icons.add_alert_rounded),
      ),
    );
  }
}
