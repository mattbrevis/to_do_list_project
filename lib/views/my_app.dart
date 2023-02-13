import 'package:flutter/material.dart';
import 'package:to_do_list_project/constants/color_theme.dart';
import 'package:to_do_list_project/constants/routes.dart';

import 'my_home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(      
      title: 'To do List Project',    
      theme: ThemeData(        
        primarySwatch: darkBlue,
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )) )),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      routes: myRoutes,
    );
  }
}