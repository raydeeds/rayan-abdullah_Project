class Task {
  final String title;
  final String description;
  bool isCompleted = false;
  String importance = '';

  Task({required this.title, required this.description, required this.importance});
}