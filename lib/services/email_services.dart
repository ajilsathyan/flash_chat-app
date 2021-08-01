import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_app/screens/chat_screen.dart';

class EmailServices {
  final _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  // User can Register
  Future<DocumentSnapshot> createUserWithEmailAndPassword(
      {password, email, context}) async {
    DocumentSnapshot result = await users.doc(email).get();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, ChatScreen.id);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  // Registered User Can Login
  Future<DocumentSnapshot> userLogin({email, password, context}) async {
    DocumentSnapshot result = await users.doc(email).get();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, ChatScreen.id);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return result;
  }

  // Reset Password
  Future<void> resetPassword({email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("time Out");
    }
  }
}
// Navigator.pushReplacementNamed(context, ChatScreen.id);
