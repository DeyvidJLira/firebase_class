import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/models/api_response.model.dart';
import 'package:firebase_class/models/person.model.dart';
import 'package:firebase_class/store/user.store.dart';
import 'package:get_it/get_it.dart';

class RegisterController {
  final _userStore = GetIt.instance.get<UserStore>();

  String _name = "";
  String _email = "";
  String _password = "";
  String _repeatPassword = "";

  changeName(String value) {
    _name = value;
  }

  changeEmail(String value) {
    _email = value;
  }

  changePassword(String value) {
    _password = value;
  }

  changeRepeatPassword(String value) {
    _repeatPassword = value;
  }

  Future<APIResponse<bool>> doRegister() async {
    try {
      if (_password != _repeatPassword) {
        return APIResponse.error("Senhas precisam ser iguais.");
      }

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      if (userCredential.user != null) {
        var person = Person(fullName: _name, email: _email);
        _userStore.loadPerson(Person(fullName: _name));
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(person.toMap());

        return APIResponse.success(true);
      } else {
        return APIResponse.error("Ops! Algum problema aconteceu!");
      }
    } on FirebaseAuthException catch (e) {
      return APIResponse.error("Ops! Algum problema aconteceu!");
    }
  }
}
