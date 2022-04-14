import 'package:auth_assignment/src/global/global.dart';
import 'package:auth_assignment/src/view/auth/login.dart';
import 'package:auth_assignment/src/view/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  Future signUp(
      {required String email,
      required String pass,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: pass);

      var authCredential = userCredential.user;

      if (authCredential!.uid.isNotEmpty) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Sign Up Failed"),
          backgroundColor: Colors.red,
        ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("The password provided is to weak"),
          backgroundColor: Colors.red,
        ));
      } else if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Email already used"),
          backgroundColor: Colors.red,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.black,
        ));
      }
    }
  }

  Future signIn(
      {required String email,
      required String pass,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: pass);

      var authCredential = userCredential.user;

      if (authCredential!.uid.isNotEmpty) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Sign Up Failed"),
          backgroundColor: Colors.red,
        ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("The password provided is to weak"),
          backgroundColor: Colors.red,
        ));
      } else if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Email already used"),
          backgroundColor: Colors.red,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.black,
        ));
      }
    }
  }
}
