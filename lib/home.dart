import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  logout() {
    print(">>>> Logging you out ...");
    _auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
