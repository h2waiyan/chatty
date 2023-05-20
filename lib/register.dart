import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/verify.dart';

import 'home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usr = TextEditingController();
  TextEditingController pwd = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flash Chat"),
      ),
      body: Column(
        children: [
          TextField(
            controller: usr,
          ),
          TextField(controller: pwd),
          ElevatedButton(
              onPressed: () async {
                print(">>>>>>>>");
                try {
                  UserCredential newUser =
                      await _auth.createUserWithEmailAndPassword(
                          email: usr.text, password: pwd.text);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  } else if (e.code == 'invalid-email') {
                    print("The email address is badly formatted.");
                  }
                } catch (err) {
                  print(err);
                } finally {
                  print(">>>> Go to verify Page");
                  User? loggedinUser = _auth.currentUser;

                  if (loggedinUser != null &&
                      loggedinUser.emailVerified == false) {
                    loggedinUser.sendEmailVerification();
                  }
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return VerifyPage();
                  }));
                }
              },
              child: const Text("Register"))
        ],
      ),
    );
  }
}
