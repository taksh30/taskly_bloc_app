import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/models/todo.dart';
import 'package:todo_app/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textCtr = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Your Task'),
        content: TextField(
          controller: textCtr,
          decoration: InputDecoration(
            fillColor: Colors.blueGrey.shade50,
            filled: true,
            hintText: 'New Task',
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              todoCubit.addTodo(
                textCtr.text.trim(),
              );
              Navigator.of(context).pop();
            },
            child: Text(
              'Add',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 23),
        title: Text('My Tasks'),
        backgroundColor: Colors.black87,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black87,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            _showAddTodoBox(context);
          }),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          if (todos.isEmpty) {
            return Center(
              child: Text(
                'No tasks added yet!',
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
            );
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Card(
                elevation: 1,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text(
                    todo.text,
                    style: TextStyle(
                      fontSize: 18,
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    activeColor: Colors.black,
                    value: todo.isCompleted,
                    onChanged: (value) {
                      todoCubit.toggleCompletion(todo);
                    },
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      todoCubit.deleteTodo(todo);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
