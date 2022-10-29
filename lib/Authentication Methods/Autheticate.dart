import 'package:chat_app/Login%20&%20SignUp/Login.dart';
import 'package:chat_app/Screens/Search%20Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) {
      return const Search();
    } else {
      return const Loginscreen();
    }
  }
}