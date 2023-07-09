import 'package:flutter/material.dart';
import 'package:todo_list/models/AddTodoResult.dart';
import 'package:todo_list/models/todo_model.dart';

class AddTodo extends StatefulWidget {
  final TodoModel? todoModel;

  const AddTodo({Key? key, this.todoModel}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodo();
}
class _AddTodo extends State<AddTodo> {

  final myController = TextEditingController();
  DateTime? dateTime;

  @override
  void initState() {
    super.initState();

    if (widget.todoModel != null) {
      myController.text = widget.todoModel!.text;
      dateTime = widget.todoModel!.deadline;
    }
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close, color: Colors.black,),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, AddTodoResult(TodoModel(
                          text: myController.text ?? '',
                          deadline: dateTime,
                          done: widget.todoModel?.done ?? false
                        ), 'save'));
                      },
                      child: Text('СОХРАНИТЬ', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary)),
                    )
                  ],
                ),
                 Card(
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
                    side: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  elevation: 5,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      //hintText: "Здесь будут мои заметки",
                    ),
                    maxLines: 5,
                    controller: myController,

                  ),
                ),
                 CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: dateTime != null,
                              activeColor: Colors.green,
                              onChanged: (value) async {
                                final res = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 10)),
                                );
                                setState(() {
                                  dateTime = res;
                                });
                              },
                        title: dateTime == null
                     ? const Text( 'Дедлайн')
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            const Text( 'Дедлайн'),
                            Text('${dateTime!.day}.${dateTime!.month}.${dateTime!.year}'),
          ],
        )

                        ),
                widget.todoModel != null ?
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, AddTodoResult(TodoModel(
                          text: myController.text ?? '',
                          deadline: dateTime,
                        ), 'delete'));
                        //Navigator.pop(context);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.delete_outline, color: Colors.red),
                          Text(' Удалить' , style: TextStyle(
                            color: Colors.red,
                          ),),
                        ],
                      ))
                    :
                    Container(),
              ]
          ),
        )
    );
  }
}

