import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/navigator_key.dart';
import 'package:firebase_class/store/user.store.dart';
import 'package:firebase_class/ui/pages/forgot_password.page.dart';
import 'package:firebase_class/ui/pages/home.page.dart';
import 'package:firebase_class/ui/pages/login.page.dart';
import 'package:firebase_class/ui/pages/register.page.dart';
import 'package:firebase_class/ui/pages/splash.page.dart';
import 'package:firebase_class/ui/pages/todo.page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.instance.registerSingleton(UserStore());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashPage(),
        "/login": (context) => const LoginPage(),
        "/register": (context) => RegisterPage(),
        "/home": (context) => const HomePage(),
        "/forgotPassword": (context) => ForgotPasswordPage(),
        "/todoList": (context) => const TodoPage(),
      },
    );
  }
}
