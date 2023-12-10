import 'package:flutter/material.dart';
import 'task_list_screen.dart';
import 'task_list_screen.dart';

void main() {
  runApp(TaskTrackerApp());
}

class TaskTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Tracker with Mood Journal',
      home: TaskListScreen(),
    );
  }
}