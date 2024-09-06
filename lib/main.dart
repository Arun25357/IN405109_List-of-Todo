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

class _TodaItem {
  String title;
  String description;

  _TodaItem(this.title, this.description);
}

class _TodoAppState extends State<TodoApp> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  final List<_TodaItem> _myList = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  void addTodoHandle(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add new task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Title",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (_titleController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty) {
                    // Add title and description to the list
                    _myList.add(_TodaItem(
                      _titleController.text,
                      _descriptionController.text,
                    ));
                    _titleController.clear(); // Clear the title field
                    _descriptionController.clear(); // Clear the description field
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
                  title: Text(_myList[index].title), // First row: Title
                  subtitle: Text(_myList[index].description), // Second row: Description
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
