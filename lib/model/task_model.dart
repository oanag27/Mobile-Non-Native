class Task {
  final int id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String priorityLevel;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priorityLevel,
    this.isCompleted = false,
  });
}
