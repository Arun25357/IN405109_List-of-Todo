import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({
    super.key,
  });

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  late TextEditingController _controller;
  final List<String> _myList = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void addTodoHandle(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add new task"),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Input your task",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  // Add new task to the list
                  if (_controller.text.isNotEmpty) {
                    _myList.add(_controller.text);
                    _controller.clear(); // Clear text field after saving
                  }
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _myList.isEmpty
          ? const Center(child: Text('No tasks yet, please add a task.'))
          : ListView.builder(
              itemCount: _myList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_myList[index]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodoHandle(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
