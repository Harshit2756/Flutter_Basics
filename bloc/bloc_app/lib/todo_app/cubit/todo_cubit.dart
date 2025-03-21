import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/todo_model.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);
  void addTodo(String title) {
    if (title.isEmpty) {
      // addError() is a method that allows you to add an error to the Cubit. This will cause the Cubit to emit an error state.
      addError('Title cannot be empty!');
      return;
    }
    final todo = Todo(
      name: title,
      createdAt: DateTime.now(),
    );
    // emit only notifies listeners if the state has changed and it checks for reference equality so on with .add() method it will not notify listeners because the reference is the same so we need to create a new list with the new todo
    // state.add(todo);
    // emit(state);
    emit([...state, todo]);
  }

  // onChanges, onError, and onEvent are lifecycle methods that can be overridden to perform actions in response to state changes, errors, and events.

  // onChanges is called whenever the state of the Cubit changes.
  @override
  void onChange(Change<List<Todo>> change) {
    super.onChange(change);
    print('TodoCubit - $change');
  }

  // onError is called whenever an uncaught error is thrown within a Cubit.
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print('TodoCubit - $error');
  }

  // onEvent is called whenever a new event is added to the Cubit.
  // @override
  // void onEvent(CubitEvent event) {
  //   super.onEvent(event);
  //   print('TodoCubit - $event');
  // }
}
