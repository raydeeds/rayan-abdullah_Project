import 'package:flutter/material.dart';
import 'task.dart';
import 'task_details_screen.dart';
import 'edit_task_screen.dart';
import 'add_task_screen.dart';
class TaskTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Tracker with importance Journal',
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  bool showCompletedTasks = true;
  String selectedimportance = '';

  List<Task> tasks = [
    Task(title: 'Task 1', description: 'click on the add icon on the bottom of the screen to add tasks', importance: 'crucial'),
    Task(title: 'Task 2', description: 'click on the task to be able to edit it ', importance: 'important'),
    Task(title: 'Task 2', description: 'swipe the task left or right to remove it ', importance: 'optional'),

  ];

  void _addTask(Task newTask) {
    setState(() {
      tasks.add(newTask);
    });
  }

  void _editTask(int index, Task editedTask) {
    setState(() {
      tasks[index] = editedTask;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Task> filteredTasks = tasks
        .where((task) =>
    (showCompletedTasks ? true : !task.isCompleted) &&
        (selectedimportance.isEmpty ? true : task.importance == selectedimportance))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                if (value == 'completed') {
                  showCompletedTasks = !showCompletedTasks;
                } else {
                  selectedimportance = value.toString();
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'completed',
                child: Text(showCompletedTasks
                    ? 'Hide Completed Tasks'
                    : 'Show Completed Tasks'),
              ),
              PopupMenuItem(
                value: '',
                child: Text('Show All importance levels'),
              ),
              PopupMenuItem(
                value: 'crucial',
                child: Text('crucial'),
              ),
              PopupMenuItem(
                value: 'important',
                child: Text('important'),
              ),
              PopupMenuItem(
                value: 'optional',
                child: Text('optional'),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (context, index) {
          String emoji;

          // Set the emoji based on task importance
          switch (filteredTasks[index].importance) {
            case 'crucial':
              emoji = '🔥';
              break;
            case 'important':
              emoji = '💡';
              break;
            case 'optional':
              emoji = '❓';
              break;
            default:
              emoji = '';
          }
          return Dismissible(
            key: Key(filteredTasks[index].title),
            onDismissed: (direction) {
              _deleteTask(index);
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 16.0),
            ),
            child: ListTile(
             title: Row(
              children: [
              Text(emoji), // Add the emoji here
              SizedBox(width: 8), // Adjust spacing as needed
              Text(filteredTasks[index].title),
          ],
          ),
              subtitle: Text(filteredTasks[index].description),
              trailing: Checkbox(
                value: filteredTasks[index].isCompleted,
                onChanged: (value) {
                  setState(() {
                    filteredTasks[index].isCompleted = value!;
                  });
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetailsScreen(
                      task: filteredTasks[index],
                      onTaskEdited: (editedTask) {
                        _editTask(index, editedTask);
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(onTaskAdded: _addTask),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}