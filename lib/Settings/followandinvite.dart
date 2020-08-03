import 'package:flutter/material.dart';

class FollowAndInvite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
           title: Text("FollowAndInvite"),
    ),
       body: Column(
         children: <Widget>[
           InkWell(
             onTap: () {
             },
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
               child: Row(
                 children: <Widget>[
                   Icon(
                     Icons.person_add,
                     size: 25,
                   ),
                   SizedBox(
                     width: 15,
                   ),
                   Expanded(
                       child: Text(
                         'Follow Contacts',
                         style: TextStyle(fontSize: 16),
                       )),
                 ],
               ),
             ),
           ),
           InkWell(
             onTap: () {
               Navigator.pushReplacement(context,
                   MaterialPageRoute(builder: (ctx) => FollowAndInvite()));
             },
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
               child: Row(
                 children: <Widget>[
                   Icon(
                     Icons.mail,
                     size: 25,
                   ),
                   SizedBox(
                     width: 15,
                   ),
                   Expanded(
                       child: Text(
                         'Invite Friends by Email',
                         style: TextStyle(fontSize: 16),
                       )),
                 ],
               ),
             ),
           ),
           InkWell(
             onTap: () {
               Navigator.pushReplacement(context,
                   MaterialPageRoute(builder: (ctx) => FollowAndInvite()));
             },
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
               child: Row(
                 children: <Widget>[
                   Icon(
                     Icons.sms,
                     size: 25,
                   ),
                   SizedBox(
                     width: 15,
                   ),
                   Expanded(
                       child: Text(
                         'Invite Friends by SMS',
                         style: TextStyle(fontSize: 16),
                       )),
                 ],
               ),
             ),
           ),
           InkWell(
             onTap: () {
               Navigator.pushReplacement(context,
                   MaterialPageRoute(builder: (ctx) => FollowAndInvite()));
             },
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
               child: Row(
                 children: <Widget>[
                   Icon(
                     Icons.share,
                     size: 25,
                   ),
                   SizedBox(
                     width: 15,
                   ),
                   Expanded(
                       child: Text(
                         'Invite Friends by...',
                         style: TextStyle(fontSize: 16),
                       )),
                 ],
               ),
             ),
           ),

         ],
       )
    );
  }
}
