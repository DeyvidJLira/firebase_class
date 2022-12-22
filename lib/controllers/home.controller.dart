import 'package:firebase_auth/firebase_auth.dart';

class HomeController {
  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
