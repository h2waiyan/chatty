import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message_bubble.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User? loggedinUser;

  TextEditingController msgCtrl = TextEditingController();

  logout() {
    print(">>>> Logging you out ...");
    _auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }));
  }

  getUser() {
    loggedinUser = _auth.currentUser;
  }

  getMessages() async {
    final messages = await _firestore.collection('messages').get(); //[<docs>]
    for (var message in messages.docs) {
      print(">>>>>>");
      print(message.data());
    }
  }

  void getMessageStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print("--------");
        print(message.data());
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    // getMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello"),
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: const Icon(Icons.logout)),
          IconButton(
              onPressed: () {
                getMessageStream();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                  stream: _firestore.collection('messages').snapshots(),
                  builder: (context, snapshot) {
                    List<Widget> messageWidgetList = [];
                    if (snapshot.hasData) {
                      var messages = snapshot.data!.docs;

                      for (var message in messages) {
                        final sender = message['sender'];
                        final text = message['message'];
                        var ownMessge = false;

                        if (sender == loggedinUser!.email) {
                          ownMessge = true;
                        }

                        final messageWidget = MessageBubble(
                          message: text,
                          sender: sender,
                          ownMessge: ownMessge,
                        );
                        messageWidgetList.add(messageWidget);
                      }
                    }

                    return Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: messageWidgetList,
                    );
                  })
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                    decoration: const InputDecoration(
                        labelText: "Type your thought . . ."),
                    controller: msgCtrl),
              ),
              ElevatedButton(
                  onPressed: () {
                    _firestore.collection('messages').add({
                      "sender": loggedinUser!.email,
                      "message": msgCtrl.text
                    });
                  },
                  child: const Text("Send"))
            ],
          ),
        ],
      ),
    );
  }
}
