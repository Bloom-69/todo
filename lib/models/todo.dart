class Todo {
  final String title;
  final String description;

  Todo({required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description};
  }

  factory Todo.fromMap(Map map) {
    return Todo(title: map['title'], description: map['description']);
  }

  @override
  String toString() {
    return 'name: $title description: $description';
  }
}
