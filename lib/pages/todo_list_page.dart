import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
   TodoListPage({super.key});



  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
 List<Todo> todos = [];

 void onDelete(Todo todo) {
   setState(() {
     todos.remove(todo);
   });
 }

 final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Widget para adicionar Tarefa
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Adicione uma Tarefa',
                      hintText: 'Ex: Estudar Flutter',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    String text = todoController.text;
                    setState(() {
                      Todo newTodo = Todo (
                        title: text,
                        dateTime: DateTime.now(),
                      );
                      todos.add(newTodo);
                    });
                    todoController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: EdgeInsets.all(13),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
            ),
                ),
              ],
            ),
            SizedBox(height: 16),
      
            // Lista de tarefas *começa*
            Flexible(
              child: ListView(
                //Esse comando se adaptará ao tamanho do conteudo.
                shrinkWrap: true,
                children: [
                  for (Todo todo in todos)
                    TodoListItem(
                      todo: todo,
                      onDelete: onDelete,
                    ),
                  ],
              
              ),
            ),
      
            // Lista de tarefas *termina*
            SizedBox(height: 16),
      
            // Widget limpar tarefas *começa*
            Row(
              children: [
                Expanded(
                  child: Text('Você possui ${todos.length} tarefas Pendentes'),
                ),
                SizedBox(width: 8),
                ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.all(13),),
                  child: Text('Limpar Tudo',style: TextStyle(color: Colors.white),),
      ),
                // Widget limpar tarefas *termina*
      
      
              ],
            ),
          ],
        ),
      ),
        ),
      ),
    );


  }
}
