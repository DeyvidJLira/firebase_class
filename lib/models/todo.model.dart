class Todo {
  String? uid;
  String title = "";
  bool isDone = false;

  Todo({this.uid, this.title = "", this.isDone = false});

  Todo copyWith({bool newIsDone = false}) {
    return Todo(uid: uid, title: title, isDone: newIsDone);
  }

  Todo.fromFirestore(Map<String, dynamic> map) {
    title = map["title"] ?? "";
    isDone = map["is_done"] ?? false;
  }

  Map<String, dynamic> toMap() {
    return {"title": title, "is_done": isDone};
  }
}
