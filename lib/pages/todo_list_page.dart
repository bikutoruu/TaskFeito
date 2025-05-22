import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adicione uma Tarefa',
                    hintText: 'Ex: Estudar Flutter',
                  ),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
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
          Row(
            children: [
              Expanded(
                child: Text('Você possui 0 tarefas Pendentes'),
              ),
              SizedBox(width: 8),
              ElevatedButton(onPressed: (){},
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              padding: EdgeInsets.all(13),),
                child: Text('Limpar Tudo',style: TextStyle(color: Colors.white),),
    ),


            ],
          ),
        ],
      ),
    ),
  ),
    );


  }


}
