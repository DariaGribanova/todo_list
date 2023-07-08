import 'package:flutter/material.dart';
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

    // Проверяем, есть ли todoModel и его текст
    if (widget.todoModel != null) {
      myController.text = widget.todoModel!.text;
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
                        Navigator.pop(context, TodoModel(
                          text: myController.text,
                          deadline: dateTime,
                        ),);
                      },
                      child: const Text('СОХРАНИТЬ'),
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
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Здесь будут мои заметки",
                    ),
                    maxLines: 5,
                    controller: myController,

                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    final res = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 10)),
                    );

                    setState(() {
                      dateTime = res;
                      //_number = res?.day ?? 0;
                    });
                  },
                  child: const Text('Pick number'),
                ),
              ]
          ),
        )
    );
  }
}

