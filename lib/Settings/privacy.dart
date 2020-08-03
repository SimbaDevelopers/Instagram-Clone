import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Privacy"),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
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
                            'Interactions',
                            style: TextStyle(fontSize: 18),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.comment,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                            'Comments',
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.supervised_user_circle,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                            'Tags',
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.restaurant_menu,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                            'Mentions',
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add_circle_outline,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                            'Story',
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                            'Activity Status',
                            style: TextStyle(fontSize: 16),
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
                            'Connections',
                            style: TextStyle(fontSize: 18),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.lock,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                            'Account Privacy',
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.block,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                            'Restricted Accounts',
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.cancel,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                            'Blocked Accounts',
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.alarm_off,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                            'Muted Accounts',
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.stars,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                            'Close Friends',
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.supervised_user_circle,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                            'Accounts You Follow',
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
