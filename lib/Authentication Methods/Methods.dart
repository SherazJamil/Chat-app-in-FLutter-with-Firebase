import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Login & SignUp/Login.dart';

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  //FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
   User? user = (await auth.createUserWithEmailAndPassword
     (email: email, password: password)).user;

   if(user != null) {
     print("Account created Successfully");
     return user;
   } else{
     print("Account create failed");
     return user;
   }
    // await firestore.collection('users').doc(auth.currentUser!.uid).set({
    //   "name": name,
    //   "email": email,
    //   "status": "Unavailable",
    //   "uid": auth.currentUser!.uid,
    // });

  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> Login (String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    User? user = (await auth.signInWithEmailAndPassword
      (email: email, password: password)).user;

    if (user != null) {
      print("Login Done");
      return user;
    } else {
      print("Login Fail");
      return user;
    }
    // firestore
    //     .collection('users')
    //     .doc(auth.currentUser!.uid)
    //     .get()
    //     .then((value) => user.user!.updateDisplayName(value['name']));


  } catch (e) {
    print(e);
    return null;
  }
}

Future LogOut(BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    await auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const Loginscreen()));
    });
  } catch (e) {
    print("error");
  }
}