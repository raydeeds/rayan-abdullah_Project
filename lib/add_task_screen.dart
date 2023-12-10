import 'package:flutter/material.dart';
import 'task.dart';
class AddTaskScreen extends StatefulWidget {
  final Function(Task) onTaskAdded;

  AddTaskScreen({required this.onTaskAdded});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController importanceController = TextEditingController(text: 'crucial');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            DropdownButtonFormField(
              value: importanceController.text,
              onChanged: (value) {
                setState(() {
                  importanceController.text = value.toString();
                });
              },
              items: ['crucial', 'important', 'optional'].map((importance) {
                return DropdownMenuItem(
                  value: importance,
                  child: Text(importance),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select an importance';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'importance'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    importanceController.text.isNotEmpty) {
                  Task newTask = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    importance: importanceController.text,
                  );
                  widget.onTaskAdded(newTask);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill in all fields'),
                    ),
                  );
                }
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
