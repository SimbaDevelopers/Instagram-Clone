

import 'package:flutter/material.dart';

class SendPostBottomSheet extends StatefulWidget {
  @override
  _SendPostBottomSheetState createState() => _SendPostBottomSheetState();
}

class _SendPostBottomSheetState extends State<SendPostBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: SingleChildScrollView(

        child: Column(

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Search....',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none
                ),
              ),
            ),
            Container(
              height: 300,
              child: ListView.builder(

                  itemCount : 25,
                  itemBuilder: (ctx , index){
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('User $index'),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
