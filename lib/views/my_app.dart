import 'package:flutter/material.dart';
import 'package:to_do_list_project/views/routes.dart';

import 'my_home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(      
      title: 'To do List Project',    
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      routes: myRoutes,
    );
  }
}