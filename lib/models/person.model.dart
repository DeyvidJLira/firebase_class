class Person {
  String fullName = "";
  String email = "";

  Person({this.fullName = "", this.email = ""});

  String get firstName => fullName.split(" ").first;
}
