import 'package:flutter/material.dart';
import 'package:system_theme/system_theme.dart';
import 'package:todoapp/screens/home.dart';

var accentColor = SystemTheme.accentColor.accent;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemTheme.accentColor.load();

  SystemTheme.onChange.listen((color) {
    SystemTheme.accentColor.load();
    accentColor = color.accent;
  });
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: accentColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
