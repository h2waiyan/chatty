import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usr = TextEditingController();
  TextEditingController pwd = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flash Chat"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Email"),
              controller: usr,
            ),
            TextField(
                decoration: const InputDecoration(labelText: "Password"),
                controller: pwd),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return RegisterPage();
                        }));
                      },
                      child: const Text("Sign Up")),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    print(">>>>>>>>");
                    try {
                      UserCredential newUser =
                          await _auth.signInWithEmailAndPassword(
                              email: usr.text, password: pwd.text);
                      print("--------");

                      print(newUser);

                      print(">>>>>>>>");
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return Home();
                      }));
                    }
                  },
                  child: const Text("Login")),
            )
          ],
        ),
      ),
    );
  }
}
