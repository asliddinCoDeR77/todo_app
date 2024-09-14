import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:todo_app/model/todo.dart';

class TodosNotifier extends ChangeNotifier {
  List<Todo> todos = [];
  bool isLoading = true;
  String errorMessage = '';

  Future<void> fetchTodos() async {
    try {
      isLoading = true;
      final dio = Dio();
      final response = await dio
          .get("https://todo-e654a-default-rtdb.firebaseio.com/todo.json");
      if (response.data != null) {
        final Map<String, dynamic> mapTodos = response.data;
        List<Todo> fetchedTodos = [];
        mapTodos.forEach((key, value) {
          final todo = Todo.fromMap({...value, 'id': key});
          fetchedTodos.add(todo);
        });
        todos = fetchedTodos;
        errorMessage = '';
      }
      isLoading = false;
    } catch (error) {
      errorMessage = 'Oops, something unexpected happened: $error';
      isLoading = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> addTodo(Todo todo) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        "https://todo-e654a-default-rtdb.firebaseio.com/todo.json",
        data: todo.toMap(),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add todo');
      }
    } catch (error) {
      print('Error adding todo: $error');
      errorMessage = 'Error adding todo: $error';
      notifyListeners();
    }
  }

  Future<void> editTodo(Todo updatedTodo) async {
    try {
      isLoading = true;
      notifyListeners();

      final dio = Dio();
      await dio.put(
        "https://todo-e654a-default-rtdb.firebaseio.com/todo/${updatedTodo.id}.json",
        data: updatedTodo.toMap(),
      );

      final index = todos.indexWhere((todo) => todo.id == updatedTodo.id);
      if (index != -1) {
        todos[index] = updatedTodo;
      }

      isLoading = false;
    } catch (error) {
      errorMessage = 'Error editing todo';
      isLoading = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      isLoading = true;
      notifyListeners();

      final dio = Dio();
      await dio.delete(
        "https://todo-e654a-default-rtdb.firebaseio.com/todo/$id.json",
      );

      todos.removeWhere((todo) => todo.id == id);

      isLoading = false;
    } catch (error) {
      errorMessage = 'Error deleting todo';
      isLoading = false;
    } finally {
      notifyListeners();
    }
  }

  Future<List<Todo>> getTodos() async {
    final dio = Dio();
    final response = await dio
        .get("https://todo-e654a-default-rtdb.firebaseio.com/todo.json");

    final Map<String, dynamic> mapTodos = response.data;
    List<Todo> todos = [];

    mapTodos.forEach((key, value) {
      final map = value as Map<String, dynamic>;
      map['id'] = key;
      final todo = Todo.fromMap(map);
      todos.add(todo);
    });

    return todos;
  }
}
