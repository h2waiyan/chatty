import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/home.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify your email")),
      body: Column(children: [
        Text(
            "We have sent your a verification email. Please verify your account."),
        ElevatedButton(
            onPressed: () {
              User? loggedinUser = _auth.currentUser;

              loggedinUser!.reload();

              print("loggin user >>>>");
              print(loggedinUser);

              if (loggedinUser != null && loggedinUser.emailVerified == false) {
                print("Please verify your email.");
              } else {
                print("Going to Home Page");

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return Home();
                }));
              }
            },
            child: Text("Already Verified"))
      ]),
    );
  }
}
