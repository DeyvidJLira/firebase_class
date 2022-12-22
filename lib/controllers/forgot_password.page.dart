import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordController {
  String _email = "";

  changeEmail(String value) {
    _email = value;
  }

  Future<String> forgotPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      return "Caso o email exista em nossa base de dados, foi enviado um link de recuperação.";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return "Ops! Algum problema aconteceu!";
    }
  }
}
