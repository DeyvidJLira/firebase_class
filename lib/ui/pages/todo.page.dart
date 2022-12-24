import 'package:firebase_class/controllers/todo.controller.dart';
import 'package:firebase_class/models/todo.model.dart';
import 'package:firebase_class/ui/components/custom_alert_dialog.component.dart';
import 'package:firebase_class/ui/components/progress_dialog.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _controller = TodoController();

  final _progressDialog = ProgressDialog();
  final _alertDialog = CustomAlertDialog();

  @override
  void initState() {
    super.initState();
    _controller.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Observer(
          builder: (_) => _controller.isLoading
              ? const SizedBox(
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  )),
                )
              : Column(
                  children: [
                    Row(children: [
                      Expanded(
                        child: TextFormField(
                          controller: _controller.textEditingController,
                          onChanged: _controller.changeTaskDescription,
                          decoration: const InputDecoration(
                              labelText: "Insira uma tarefa..."),
                        ),
                      ),
                      IconButton(
                        onPressed: _addTodo,
                        icon: const Icon(Icons.add),
                      )
                    ]),
                    Expanded(
                      child: _controller.todoList.isEmpty
                          ? const SizedBox(
                              child:
                                  Center(child: Text("Sem tarefa adicionada!")),
                            )
                          : ListView.builder(
                              itemCount: _controller.todoList.length,
                              itemBuilder: (context, index) => Dismissible(
                                key: ValueKey<int>(index),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  _deleteTodo(_controller.todoList[index]);
                                },
                                child: CheckboxListTile(
                                  value: _controller.todoList[index].isDone,
                                  onChanged: (value) {
                                    _updateTodo(
                                        index, _controller.todoList[index]);
                                  },
                                  title:
                                      Text(_controller.todoList[index].title),
                                ),
                              ),
                            ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  _addTodo() async {
    _progressDialog.show("Adicionando...");
    var response = await _controller.add();
    _progressDialog.hide();
    if (response.isError) {
      _alertDialog.showInfo(title: "Ops!", message: response.message!);
    }
  }

  _updateTodo(int index, Todo item) async {
    _progressDialog.show("Atualizando...");
    item.isDone = !item.isDone;
    final response = await _controller.update(index, item);
    _progressDialog.hide();
    if (response.isError) {
      _alertDialog.showInfo(title: "Ops!", message: response.message!);
    }
  }

  _deleteTodo(Todo item) async {
    _progressDialog.show("Excluindo...");
    final response = await _controller.delete(item);
    _progressDialog.hide();
    if (response.isError) {
      _alertDialog.showInfo(title: "Ops!", message: response.message!);
    }
  }
}
