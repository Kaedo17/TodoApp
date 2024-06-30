import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:listapp/main.dart';
import 'package:listapp/utils/todo_list.dart';

class ToDoDataBase {
  List toDoList = [];

  final _myBox = Hive.box('mybox');

  //first time open the app

  void createInitialData() {
    toDoList = [
      ['Cook an egg!', false]
    ];
  }

  //load data from the database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update databse

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
