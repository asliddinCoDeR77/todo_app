import 'dart:convert';

class Todo {
  String id;
  String title;
  DateTime dateTime;
  bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.isDone,
  });

  factory Todo.fromMap(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      dateTime: DateTime.parse(json['DATETIME'] as String),
      isDone: json['isDone'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'DATETIME': dateTime.toIso8601String(),
      'isDone': isDone,
    };
  }

  String toJson() => json.encode(toMap());

  Todo copyWith({
    String? id,
    String? title,
    DateTime? dateTime,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      isDone: isDone ?? this.isDone,
    );
  }
}
