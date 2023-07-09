import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_model.dart';
import 'add_todo.dart';


class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<TodoModel> _todos = [];
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        centerTitle: true,
        title: Text(
          'Мои дела',
          style: themeData.textTheme.headlineSmall?.copyWith(),
        ),
      ),

      body: SafeArea(
        top: false,
        child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Выполнено - ${_todos.where((element) => element.done!).length}', style: themeData.textTheme.bodyLarge?.copyWith(color: themeData.colorScheme.tertiary, fontWeight: FontWeight.w700)),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isVisible ? isVisible = false : isVisible = true;
                      });
                    },
                    child: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                  )
                ],
              ),







    LayoutBuilder(
    builder: (context, constraints) {
      return Card(
        surfaceTintColor: Colors.white,
        margin: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 5,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
        ),
        elevation: 5,
        color: Colors.white,
        child: ListView.builder(
            itemCount: isVisible ? _todos.length : _todos
                .where((element) => !element.done!)
                .toList()
                .length,
            itemBuilder: (context, index) {
              final filteredTodos = isVisible ? _todos : _todos.where((
                  element) => !element.done!).toList();
              return Dismissible(
                direction: filteredTodos[index].done == true ? DismissDirection.endToStart : DismissDirection.horizontal,
                  background: Container(
                    color: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.check, color: Colors.white,),
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  key: ValueKey<TodoModel>(filteredTodos[index]),
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.endToStart) {
                      setState(() {
                        _todos.removeAt(_todos.indexOf(filteredTodos[index]));
                      });
                    } else if (direction == DismissDirection.startToEnd){
                      setState(() {
                        _todos[_todos.indexOf(filteredTodos[index])] =
                            filteredTodos[index].copyWith(
                              done: true,
                            );
                      });
                    }
                  },
                  child: CheckboxListTile(
                    title: GestureDetector(
                        onTap: () {
                          _editTodo(context, filteredTodos[index]);
                        },
                        child: filteredTodos[index].deadline == null
                            ? Text(filteredTodos[index].text,
                          //style: themeData.textTheme.bodyLarge?.copyWith(),
                          style: TextStyle(
                            decoration: filteredTodos[index].done!
                                ? TextDecoration.lineThrough
                                : null,
                            color: filteredTodos[index].done!
                                ? Colors.grey
                                : Colors.black,
                          ),
                        )
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(filteredTodos[index].text,
                              style: TextStyle(
                                decoration: filteredTodos[index].done!
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: filteredTodos[index].done!
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            Text('${filteredTodos[index].deadline!
                                .day}.${filteredTodos[index].deadline!
                                .month}.${filteredTodos[index].deadline!.year}',
                              style: TextStyle(
                                fontSize: 14,
                                height: 20 / 14,
                                decoration: filteredTodos[index].done!
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: filteredTodos[index].done!
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ],
                        )
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: filteredTodos[index].done,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      final checked = value ?? false;
                      setState(() {
                        _todos[_todos.indexOf(filteredTodos[index])] =
                            filteredTodos[index].copyWith(
                              done: checked,
                            );
                      });
                    },
                  )
              );
            },
          shrinkWrap: true,
        ),
      );
    }
        ),




            ]
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodo(context);
        },
          backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> _addTodo(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTodo()),
    );
    if (!mounted) return;
    if (result != null) {
      setState(
            () {
          _todos.add(
            result.todoModel,
          );
        },
      );
    }
  }


  Future<void> _editTodo(BuildContext context, TodoModel? todoModel) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTodo(todoModel: todoModel)),
    );
    if (!mounted) return;
    if (result != null) {
      if (result.buttonId == 'save') {
        setState(
              () {
                _todos[_todos.indexOf(todoModel!)] = result.todoModel;
          },
        );
      } else if (result.buttonId == 'delete'){
        setState(
              () {
            _todos.remove(todoModel);
          },
        );
      }
    }
  }

}
