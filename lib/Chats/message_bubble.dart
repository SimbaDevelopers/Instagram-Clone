import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

 class MessageBubble extends StatelessWidget {
  MessageBubble(
      this.message,
      this.isMe,);

  final String message;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.white10 : Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            border: Border.all(width: .08,color: Colors.white),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(
            vertical: 16,
          horizontal: 16,),
          margin: isMe? EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ) : EdgeInsets.only(
            left: 40,
            right: 16,
            top: 5,
            bottom:5
          ),
          child: Text(
          message,
            style: TextStyle(
              color: Colors.white),
          ),
        ),
      ],
    );
  }
}
