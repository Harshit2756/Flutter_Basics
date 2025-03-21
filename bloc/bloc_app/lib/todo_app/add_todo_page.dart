import 'package:bloc_app/todo_app/cubit/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/todo_model.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final todoTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: BlocListener<TodoCubit, List<Todo>>(
        listener: (context, state) {},
        listenWhen: (previous, current) => false,
        child: BlocListener<TodoCubit, List<Todo>>(
          listener: (context, state) {
            context.read<TodoCubit>().stream.listen(
              (state) {},
              onError: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error.toString())),
                );
              },
            );
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: todoTitleController,
                  decoration: const InputDecoration(hintText: 'Title'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final title = todoTitleController.text.trim();
                    context.read<TodoCubit>().addTodo(title);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
