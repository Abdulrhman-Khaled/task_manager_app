class TaskModel {
  String? id;
  final String userId;
  final String title;
  final String description;
  final String dueDate;
  final bool isCompleted;
  final String priority;
  List<String> filesLinks = [];

  TaskModel({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
    required this.priority,
    required this.filesLinks,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      dueDate: json['dueDate'],
      isCompleted: json['isCompleted'],
      priority: json['priority'],
      filesLinks: List<String>.from(json['filesLinks']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'isCompleted': isCompleted,
      'priority': priority,
      'filesLinks': filesLinks,
    };
  }
}
