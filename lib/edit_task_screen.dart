import 'package:flutter/material.dart';
import 'task.dart';
class EditTaskScreen extends StatefulWidget {
  final Task task;
  final Function(Task) onTaskEdited;

  EditTaskScreen({required this.task, required this.onTaskEdited});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController importanceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description;
    importanceController.text = widget.task.importance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
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
              decoration: InputDecoration(labelText: 'importance'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    importanceController.text.isNotEmpty) {
                  Task editedTask = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    importance: importanceController.text,
                  );
                  widget.onTaskEdited(editedTask);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill in all fields'),
                    ),
                  );
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}