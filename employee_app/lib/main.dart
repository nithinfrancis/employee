import 'package:employee_app/screen/employee_list/employee_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpers/db_helper.dart';
import 'screen/app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.dbhOpenDatabase();


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => EmployeeProvider()),
  ], child: const MyApp()));
}
