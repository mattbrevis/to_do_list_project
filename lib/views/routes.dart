import 'package:to_do_list_project/views/tasks/list_tasks_page.dart';
import 'package:to_do_list_project/views/my_home.dart';
import 'package:to_do_list_project/views/tasks/new_task_page.dart';

final myRoutes ={ 
  'home' : (context) => const MyHomePage(),
  'new_task' : (context)=> const NewTaskPage(),
  'list_task' : (context)=> const ListTaskPage()
};