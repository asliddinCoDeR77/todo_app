import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/providers/todos_provider.dart';

class AddTodoScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            ElevatedButton(
              onPressed: () {
                final newTodo = Todo(
                  id: '',
                  title: titleController.text,
                  dateTime: DateTime.now(),
                  isDone: false,
                );

                context.read<TodosNotifier>().addTodo(newTodo);
                Navigator.of(context).pop();
              },
              child: Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
