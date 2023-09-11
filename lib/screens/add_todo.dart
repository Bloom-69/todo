import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  AddTodoScreenState createState() => AddTodoScreenState();
}

class AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Todo newTodo = Todo(
        title: _title,
        description: _description,
        isCompleted: false,
      );

      Navigator.pop(context, newTodo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
        title: const Text('Add tasks'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (input) =>
                    input!.trim().isEmpty ? 'Please enter a title' : null,
                onSaved: (input) => _title = input!,
                initialValue: _title,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (input) =>
                    input!.trim().isEmpty ? 'Please enter a description' : null,
                onSaved: (input) => _description = input!,
                initialValue: _description,
              ),
            ),
            FilledButton(
              onPressed: _submit,
              child: const Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
