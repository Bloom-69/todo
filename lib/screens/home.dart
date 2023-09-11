import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/screens/add_todo.dart';
import 'package:todoapp/screens/settings.dart';
import 'package:todoapp/services/todo_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    getTodo();
  }

  void getTodo() {
    final todoService = TodoService();
    final todos = todoService.getTodoList();
    setState(() {
      _todos = todos;
    });
  }

  void _navigateToAddTodo() async {
    final newTodo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTodoScreen()),
    );

    if (newTodo != null) {
      setState(() {
        _todos.add(newTodo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
        title: const Text('Todo App'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(left: 10, right: 10),
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceVariant,
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                child: ListTile(
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      setState(() {
                        todo.isCompleted = value!;
                      });
                    },
                  ),
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                ),
                onLongPress: () {
                  Scaffold.of(context).showBottomSheet<void>(
                      elevation: 5,
                      (BuildContext context) => Container(
                            padding: const EdgeInsets.only(top: 25),
                            height: 240,
                            child: Column(children: <Widget>[
                              ListTile(
                                title: const Text("Delete"),
                                leading: const Icon(Icons.delete),
                                onTap: () {
                                  setState(() {
                                    _todos.removeAt(index);
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                title: const Text("Mark as Completed"),
                                leading: const Icon(Icons.check),
                                onTap: () {
                                  setState(() {
                                    todo.isCompleted = true;
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ]),
                          ));
                },
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTodo,
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
