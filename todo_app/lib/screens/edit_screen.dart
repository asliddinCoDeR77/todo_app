import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/providers/todos_provider.dart';

class EditTodoScreen extends StatelessWidget {
  final Todo todo;

  EditTodoScreen({required this.todo});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleController.text = todo.title;
    _dateController.text = todo.dateTime.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: todo.dateTime,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  _dateController.text = pickedDate.toIso8601String();
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Todo updatedTodo = Todo(
                  id: todo.id,
                  title: _titleController.text,
                  dateTime: DateTime.parse(_dateController.text),
                  isDone: todo.isDone,
                );

                Provider.of<TodosNotifier>(context, listen: false)
                    .editTodo(updatedTodo);
                Navigator.of(context).pop();
              },
              child: Text('Update Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
