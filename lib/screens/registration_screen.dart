import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_app/services/email_services.dart';
import 'package:simple_chat_app/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration-screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  bool obscureText = true;
  bool isLoading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  EmailServices _emailServices = EmailServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: CircularProgressIndicator(),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: "flash-logo",
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Enter your email",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    controller: passwordController,
                    obscureText: obscureText,
                    keyboardType: TextInputType.visiblePassword,
                    maxLength: 8,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye_fill,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Enter password",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    buttonTitle: "Register",
                    buttonColor: Colors.blueAccent,
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                        email = emailController.text;
                        password = passwordController.text;
                      });
                      _emailServices
                          .createUserWithEmailAndPassword(
                              context: context,
                              email: email,
                              password: password)
                          .then((value) {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//'com.google.firebase:firebase-analytics:19.0.0'
