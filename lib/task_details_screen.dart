import 'package:flutter/material.dart';
import 'edit_task_screen.dart';
import 'task.dart';
class TaskDetailsScreen extends StatefulWidget {
  final Task task;
  final Function(Task) onTaskEdited;

  TaskDetailsScreen({required this.task, required this.onTaskEdited});

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController moodController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description;
    moodController.text = widget.task.importance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(
                    task: widget.task,
                    onTaskEdited: widget.onTaskEdited,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${widget.task.title}'),
            Text('Description: ${widget.task.description}'),
            Text('Status: ${widget.task.isCompleted ? 'Completed' : 'Pending'}'),
            Text('Importance: ${widget.task.importance}'),
          ],
        ),
      ),
    );
  }
}
