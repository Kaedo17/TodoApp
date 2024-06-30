// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:listapp/main.dart';
import 'package:listapp/data/database.dart';
import 'package:listapp/utils/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

final _controller = TextEditingController();

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');

  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // TODO: implement initState

    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChange(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
    });
    db.updateDataBase();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: appBarList(),
      body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (BuildContext context, index) {
            return TodoList(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChange(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          }),
      floatingActionButton: Row(
        children: [
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    hintText: 'Add To do list',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.grey,
                    contentPadding: EdgeInsets.all(15)),
              ),
            ),
          )),
          FloatingActionButton(
            backgroundColor: Colors.grey[900],
            onPressed: () {
              saveNewTask();
              _controller.clear();
            },
            child: Icon(
              Icons.add,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  AppBar appBarList() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'To Do',
        style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.grey[900],
    );
  }
}
