import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/configs/theme.dart';
import 'package:todo_list/providers/task_provider.dart';
import 'package:todo_list/screens/splash.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('tasks');

  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: Splash(),
    );
  }
}
