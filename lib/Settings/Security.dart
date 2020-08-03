import 'package:flutter/material.dart';
class Security extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Security"),
        ),
        body:Column(
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
                          'Login Security',
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
                          'Password',
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
                      Icons.location_on,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Login Activity',
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
                      Icons.save,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Saved Login Info',
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
                      Icons.rate_review,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Two-Factor Authentication',
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
                      Icons.email,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Emails From Instagram',
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
                          'Data and History',
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
                      Icons.data_usage,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Access Data',
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
                      Icons.file_download,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Download Data',
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
                      Icons.apps,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Apps and Websites',
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
                      Icons.search,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Search History',
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
