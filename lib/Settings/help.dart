import 'package:flutter/material.dart';
class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Help"),
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
                        'Report a Problem',
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
                        'Help Center',
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
                        'Privacy and Security Help',
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
