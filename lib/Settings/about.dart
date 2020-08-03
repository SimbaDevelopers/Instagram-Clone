import 'package:flutter/material.dart';
class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("About"),
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
                        'Data Policy',
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
                        'Terms Of Use',
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
                        'Open Source Libraries',
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
