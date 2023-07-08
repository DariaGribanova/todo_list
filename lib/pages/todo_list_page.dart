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
                  Text('Выполнено - ${_todos.where((element) => element.done).length}'),
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
              Expanded(
                child: Card(
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
                  child: ListView.builder(
                      itemCount: isVisible ? _todos.length : _todos.where((element) => !element.done).toList().length,
                      itemBuilder: (context, index) {
                        final filteredTodos = isVisible ? _todos : _todos.where((element) => !element.done).toList();
                        return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: filteredTodos[index].done,
                          onChanged: (value) {
                            final checked = value ?? false;
                            setState(() {
                              _todos[_todos.indexOf(filteredTodos[index])] = filteredTodos[index].copyWith(
                                done: checked,
                              );
                            });
                          },
                          title: Text(filteredTodos[index].text),
                        );
                      }
                  ),
                ),
              ),
            ]
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodo(context);
        },
        child: const Icon(Icons.add),
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
            result,
          );
        },
      );
    }
  }

}
