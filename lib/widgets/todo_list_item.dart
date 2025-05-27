import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/todo.dart';



class TodoListItem extends StatelessWidget {
  const TodoListItem({super.key, required this.todo,  required this.onDelete});

  final Todo todo;
  final Function(Todo) onDelete;


  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(todo.title),
      endActionPane: ActionPane(
    motion : const DrawerMotion(),
    children: [
      SlidableAction(
    onPressed: (_) => onDelete(todo),
    icon: Icons.delete,
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
    label: 'Deletar',
    ),
    ],
    ),
      child:  Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[200],
        ),
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(

              DateFormat('dd/MMM/yyyy - HH:mm').format(todo.dateTime),
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              todo.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
