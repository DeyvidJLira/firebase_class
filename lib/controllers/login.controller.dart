import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/models/api_response.model.dart';
import 'package:firebase_class/models/person.model.dart';
import 'package:firebase_class/store/user.store.dart';
import 'package:get_it/get_it.dart';

class LoginController {
  final _userStore = GetIt.instance.get<UserStore>();

  String _email = "";
  String _password = "";

  changeEmail(String value) {
    _email = value;
  }

  changePassword(String value) {
    _password = value;
  }

  Future<APIResponse<bool>> doLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      if (userCredential.user != null) {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .get();
        Person person =
            Person.fromFirestore(snapshot.data() as Map<String, dynamic>);
        _userStore.loadPerson(person);
        return APIResponse.success(true);
      } else {
        return APIResponse.error("Ops! Algum problema aconteceu!");
      }
    } catch (exception) {
      return APIResponse.error((exception as FirebaseAuthException).message);
    }
  }
}
