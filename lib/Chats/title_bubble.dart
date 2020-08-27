import 'package:flutter/material.dart';

class TitleBubble extends StatelessWidget {
  TitleBubble(this.tovideocall,this.username);

 final bool tovideocall;
final String username;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: tovideocall ? Text("You started a video call",
            style: TextStyle(
                color: Colors.grey,fontWeight: FontWeight.bold),) :
          Text("$username started a video call",
            style: TextStyle(
                color: Colors.grey,fontWeight: FontWeight.bold),)
        )
      ],
    );
  }
}
