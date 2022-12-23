// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/controllers/login.controller.dart';
import 'package:firebase_class/models/person.model.dart';
import 'package:firebase_class/store/user.store.dart';
import 'package:firebase_class/ui/components/custom_alert_dialog.component.dart';
import 'package:firebase_class/ui/components/progress_dialog.component.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = LoginController();

  final _progressDialog = ProgressDialog();
  final _alertDialog = CustomAlertDialog();

  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => preload());
  }

  Future preload() async {
    _streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        await _streamSubscription!.cancel();
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
  }

  @override
  void dispose() async {
    super.dispose();
    if (_streamSubscription != null) await _streamSubscription!.cancel();
  }

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
              onPressed: () => Navigator.pushNamed(context, "/forgotPassword"),
              child: const Text("Esqueci a senha"),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: double.maxFinite,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/register"),
                child: const Text("Se Cadastrar"),
              ),
            ),
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
