import 'package:employee_app/screen/employee_list/employee_list_screen.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
      ),
      home: EmployeeListScreen(),
    );
  }
}
