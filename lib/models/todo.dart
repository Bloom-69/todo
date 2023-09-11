class Todo {
  final String title;
  final String description;
  bool isCompleted;

  Todo(
      {required this.title,
      required this.description,
      required this.isCompleted});

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description};
  }

  factory Todo.fromMap(Map map) {
    return Todo(
        title: map['title'],
        description: map['description'],
        isCompleted: map['isCompleted']);
  }

  @override
  String toString() {
    return 'name: $title description: $description isCompleted $isCompleted';
  }
}
