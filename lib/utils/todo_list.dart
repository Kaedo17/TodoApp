import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {
  TodoList(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      this.onChanged,
      required this.deleteFunction});

  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            backgroundColor: Colors.red,
            onPressed: deleteFunction,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(20),
          )
        ]),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: taskCompleted ? Colors.green : Colors.grey[900]),
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.green[700],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    style: TextStyle(
                        color: taskCompleted ? Colors.white : Colors.grey[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    taskName,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
