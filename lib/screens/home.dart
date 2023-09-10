import 'package:flutter/material.dart';
import 'package:todoapp/screens/add_todo.dart';
import 'package:todoapp/models/todo.dart';
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
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.description),
            onTap: () {
              Scaffold.of(context).showBottomSheet<void>(
                  elevation: 5,
                  (BuildContext context) => Container(
                        padding: const EdgeInsets.only(top: 25),
                        height: 120,
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
                          )
                        ]),
                      ));
            },
          );
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
