import 'package:flutter/material.dart';
import 'package:todo_list/pages/todo_list_page.dart';



void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
   Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  TodoListPage() ,
    );
  }
}
