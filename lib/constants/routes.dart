import 'package:to_do_list_project/views/tasks/list_tasks_page.dart';
import 'package:to_do_list_project/views/home_page.dart';
import 'package:to_do_list_project/views/tasks/task_page.dart';

final myRoutes ={ 
  'home' : (context) => const MyHomePage(),
  'new_task' : (context)=> const TaskPage(task: null,),
  'list_task' : (context)=> const ListTaskPage()
};