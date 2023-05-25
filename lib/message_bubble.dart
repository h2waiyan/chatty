import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  final String message;
  final String sender;
  final bool ownMessge;

  const MessageBubble(
      {super.key,
      required this.message,
      required this.sender,
      required this.ownMessge});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: Main,
      crossAxisAlignment:
          widget.ownMessge ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(widget.sender),
        Container(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(widget.message),
          ),
        )
      ],
    );
  }
}
