import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_page.dart';
import 'package:http/http.dart' as http;

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List items = [];

  @override
  void initState() {
    fetchTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 11, 2),
        title: const Center(
          child: Text(
            'Appbar',
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: Text(item.toString()),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 20, 11, 2),
        onPressed: navigateToAddPage,
        label: const Text(
          'Add Todo',
          style: TextStyle(color: Colors.amber),
        ),
      ),
    );
  }

  void navigateToAddPage() {
    final route = MaterialPageRoute(builder: (context) => const AddTodoPage());
    Navigator.push(context, route);
  }

  // GET API

  Future<void> fetchTodo() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    }
  }
}
