import '../models/todo.dart';

class TodoService {
  final List<Todo> _todoList = [];

  // Get all todos
  List<Todo> getTodoList() {
    return _todoList;
  }

  // Add a todo
  void addTodo(Todo todo) {
    _todoList.add(todo);
  }

  // Delete a todo
  void deleteTodo(Todo todo) {
    _todoList.remove(todo);
  }

  // Update a todo
  void updateTodo(Todo oldTodo, Todo newTodo) {
    int index = _todoList.indexOf(oldTodo);
    if (index != -1) {
      _todoList[index] = newTodo;
    }
  }
}
