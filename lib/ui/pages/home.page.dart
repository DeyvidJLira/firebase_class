import 'package:firebase_class/controllers/home.controller.dart';
import 'package:firebase_class/store/user.store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _userStore = GetIt.instance.get<UserStore>();
  final _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meu App")),
      drawer: Drawer(
        backgroundColor: Colors.blue,
        child: ListView(
          children: [
            DrawerHeader(
                child: Container(
              color: Colors.white,
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
