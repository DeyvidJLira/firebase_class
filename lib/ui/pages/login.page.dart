import 'package:firebase_class/controllers/login.controller.dart';
import 'package:firebase_class/navigator_key.dart';
import 'package:firebase_class/ui/components/custom_alert_dialog.component.dart';
import 'package:firebase_class/ui/components/progress_dialog.component.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _controller = LoginController();

  final _progressDialog = ProgressDialog();
  final _alertDialog = CustomAlertDialog();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Email"),
              onChanged: _controller.changeEmail,
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(labelText: "Senha"),
              onChanged: _controller.changePassword,
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: double.maxFinite,
              height: 48,
              child: ElevatedButton(
                onPressed: _doLogin,
                child: const Text("Entrar"),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {},
              child: Text("Esqueci a senha"),
            )
          ],
        ),
      ),
    );
  }

  _doLogin() async {
    _progressDialog.show("Autenticando...");
    final response = await _controller.doLogin();
    if (response.isSuccess) {
      print("Pegadinha do madara");
    } else {
      _progressDialog.hide();
      _alertDialog.showInfo(title: "Ops!", message: response.message!);
    }
  }
}
