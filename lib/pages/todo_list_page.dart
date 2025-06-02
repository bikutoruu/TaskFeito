import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../reposidores/todo_repository.dart';
import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> todos = [];
  final TodoRepository todoRepository = TodoRepository();

  Todo? deletedTodo;
  int? deletedTodoPos;

  @override
  void initState() {
    super.initState();
    todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });
    todoRepository.saveTodoList(todos);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tarefa ${todo.title} foi removida com sucesso!',
          style: TextStyle(color: Color(0xff060708)),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: Colors.indigo,
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
            });
            todoRepository.saveTodoList(todos);
          },
        ),
        duration: Duration(seconds: 5),
      ),
    );
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
                Row(
                    children: [
                      Flexible(
                        child: Image.asset(
                          'assets/icons/taskfeito_icon.png',

                        ),
                      ),
                      Flexible(
                        child: Image.asset(
                            'assets/icons/taskfeito_branding.png'
                        ),
                      )

                    ]

                ),
                SizedBox(height: 16),
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
                        if (todoController.text.isNotEmpty) {
                          String text = todoController.text;
                          setState(() {
                            Todo newTodo = Todo(
                              title: text,
                              dateTime: DateTime.now(),
                            );
                            todos.add(newTodo);
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 3),
                                  content: Text(
                                    'Tarefa adicionada com sucesso!',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                            );
                          });
                          todoController.clear();
                          todoRepository.saveTodoList(todos);
                        } else if (todoController.text.isEmpty) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 5),
                              content: Text(
                                'Não é possível adicionar uma tarefa vazia!',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: EdgeInsets.all(13),
                      ),
                      child: Icon(Icons.add, size: 30, color: Colors.white),
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
                        TodoListItem(todo: todo, onDelete: onDelete),
                    ],
                  ),
                ),

                // Lista de tarefas *termina*
                SizedBox(height: 16),

                // Widget limpar tarefas *começa*
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Você possui ${todos.length} tarefas Pendentes',
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: showDeletConfirmation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: EdgeInsets.all(13),
                      ),
                      child: Text(
                        'Limpar Tudo',
                        style: TextStyle(color: Colors.white),
                      ),
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

  void showDeletConfirmation() {
    if(todos.length == 0){
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          content: Text(
            'Você não possui tarefas pendentes!',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if(todos.length > 0){
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Limpar Tudo?'),
            content: Text(
              'Você tem certeza que deseja apagar todas as tarefas?',
            ),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              },
                  style: TextButton.styleFrom(foregroundColor: Colors.indigo),
                  child: Text('Cancelar')),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    deleteAllTodos();
                    todoRepository.saveTodoList(todos);
                  });
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: Text('Limpar Tudo'),
              ),
            ],
          ),
    );
    }
  }

  void deleteAllTodos() {
    todos.clear();
  }
}
