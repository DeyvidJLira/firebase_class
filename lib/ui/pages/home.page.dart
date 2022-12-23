// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/controllers/home.controller.dart';
import 'package:firebase_class/store/user.store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userStore = GetIt.instance.get<UserStore>();
  final _controller = HomeController();

  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => preload());
  }

  Future preload() async {
    _streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user == null) {
        await _streamSubscription!.cancel();
        Navigator.pushReplacementNamed(context, "/login");
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
    return Scaffold(
      appBar: AppBar(title: const Text("Meu App")),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
                child: Container(
              color: Colors.blue,
              child: const Center(
                  child: FlutterLogo(
                size: 144,
              )),
            )),
            TextButton(onPressed: _controller.logout, child: const Text("Sair"))
          ],
        ),
      ),
      body: SizedBox(
        child: Center(
          child: Text("Bem vindo de volta, ${_userStore.person!.firstName}"),
        ),
      ),
    );
  }
}
