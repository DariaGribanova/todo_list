import 'package:todo_list/models/todo_model.dart';

class AddTodoResult {
  final TodoModel todoModel;
  final String buttonId;

  AddTodoResult(this.todoModel, this.buttonId);
}
