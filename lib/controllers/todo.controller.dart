import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/models/api_response.model.dart';
import 'package:firebase_class/models/todo.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'todo.controller.g.dart';

class TodoController = TodoControllerBase with _$TodoController;

abstract class TodoControllerBase with Store {
  @readonly
  bool _isLoading = true;

  @readonly
  String _taskDescription = "";

  TextEditingController textEditingController = TextEditingController();

  ObservableList<Todo> todoList = ObservableList();

  @action
  changeTaskDescription(String value) {
    _taskDescription = value;
  }

  @action
  Future<APIResponse<Todo>> add() async {
    try {
      var userCredential = FirebaseAuth.instance.currentUser;
      Todo todo = Todo(title: _taskDescription);
      if (userCredential != null) {
        var docRef = await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.uid)
            .collection("tasks")
            .add(todo.toMap());
        todo.uid = docRef.id;
        todoList.add(todo);
        textEditingController.clear();
        _taskDescription = "";
        return APIResponse.success(todo);
      } else {
        return APIResponse.error("Ops! Algum problema aconteceu!");
      }
    } on FirebaseAuthException catch (e) {
      return APIResponse.error("Ops! Algum problema aconteceu!");
    }
  }

  @action
  Future<APIResponse<List<Todo>>> getAll() async {
    try {
      _isLoading = true;
      var userCredential = FirebaseAuth.instance.currentUser;
      if (userCredential != null) {
        QuerySnapshot query = await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.uid)
            .collection("tasks")
            .get();
        todoList.clear();
        for (var doc in query.docs) {
          Todo todo = Todo.fromFirestore(doc.data() as Map<String, dynamic>);
          todo.uid = doc.id;
          todoList.add(todo);
        }
        _isLoading = false;
        return APIResponse.success(todoList);
      } else {
        _isLoading = false;
        return APIResponse.error("Ops! Algum problema aconteceu!");
      }
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      return APIResponse.error("Ops! Algum problema aconteceu!");
    }
  }

  @action
  Future<APIResponse<bool>> update(int index, Todo todo) async {
    try {
      var userCredential = FirebaseAuth.instance.currentUser;
      if (userCredential != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.uid)
            .collection("tasks")
            .doc(todo.uid)
            .update(todo.toMap());
        todoList[index] = todo.copyWith(newIsDone: todo.isDone);
        return APIResponse.success(true);
      } else {
        return APIResponse.error("Ops! Algum problema aconteceu!");
      }
    } on FirebaseAuthException catch (e) {
      return APIResponse.error("Ops! Algum problema aconteceu!");
    }
  }

  @action
  Future<APIResponse<bool>> delete(Todo todo) async {
    try {
      var userCredential = FirebaseAuth.instance.currentUser;
      if (userCredential != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.uid)
            .collection("tasks")
            .doc(todo.uid)
            .delete();
        todoList.remove(todo);
        return APIResponse.success(true);
      } else {
        return APIResponse.error("Ops! Algum problema aconteceu!");
      }
    } on FirebaseAuthException catch (e) {
      return APIResponse.error("Ops! Algum problema aconteceu!");
    }
  }
}
