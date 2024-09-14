import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todos_provider.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/screens/edit_screen.dart';

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TodosNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (notifier.errorMessage.isNotEmpty) {
            return Center(child: Text(notifier.errorMessage));
          }
          return ListView.builder(
            itemCount: notifier.todos.length,
            itemBuilder: (context, index) {
              final todo = notifier.todos[index];
              return ListTile(
                title: Text(todo.title),
                subtitle: Text('Date: ${todo.dateTime}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => EditTodoScreen(todo: todo)),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        notifier.deleteTodo(todo.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddTodoScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
