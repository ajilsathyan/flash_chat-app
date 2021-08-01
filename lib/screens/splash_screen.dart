import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_app/screens/chat_screen.dart';
import 'package:simple_chat_app/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {

  static const String id='splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
      Timer(Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        // Not Signed in case
        if (user == null) {
          Navigator.pushReplacementNamed(context, WelcomeScreen.id);
          // Signed In case
        } else {
          Navigator.pushReplacementNamed(context,ChatScreen.id);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 100, height: 100, child: Image.asset("images/logo.png")),
            SizedBox(height: 10),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText("Flash Chat",
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      ),
    );
  }
}
