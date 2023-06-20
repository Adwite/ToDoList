import 'package:flutter/cupertino.dart';

class Todo{
  String? id;
  String? todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone=false,
});

  static List<Todo> todolist(){
    return[];
  }

}