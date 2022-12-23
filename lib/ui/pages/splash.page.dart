// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/firebase_options.dart';
import 'package:firebase_class/models/person.model.dart';
import 'package:firebase_class/store/user.store.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  StreamSubscription? _streamSubscription;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => preload());
  }

  Future preload() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "/login");
      } else {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        Person person =
            Person.fromFirestore(snapshot.data() as Map<String, dynamic>);
        GetIt.instance.get<UserStore>().loadPerson(person);
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await _streamSubscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.blue,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}
