import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
        title: Text("Notifications"),
    ),
    body: Column(
    children: <Widget>[

      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Text(
                    'Push Notifications',
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Text(
                    'Pause All',
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Text(
                    'Posts,Stories adn Comments',
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Text(
                    'Following and Followers',
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Text(
                    'Direct Messages',
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Text(
                    'Live and IGTV',
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Text(
                    'From Instagram',
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Text(
                    'Other Notification Types',
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Text(
                    'Email and SMS',
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          ),
        ),
      ),

    ])
    );
  }
}
