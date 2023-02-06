import 'package:flutter/material.dart';
import 'package:to_do_list_project/model/task_model.dart';

import 'package:to_do_list_project/repository/task_repository.dart';
import 'views/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

 
  

  runApp(const MyApp());
}
