import 'package:flutter/material.dart';
import 'package:instagram/widgets/Storybar.dart';

class StoryHighights extends StatefulWidget {
  @override
  _StoryHighightsState createState() => _StoryHighightsState();
}

class _StoryHighightsState extends State<StoryHighights> {
  bool toggle = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              toggle = !toggle;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 18, right: 18 , bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(child: Text('Story Highlights')),
                Text('▼'),
              ],
            ),
          ),
        ),
        toggle
            ? StoryBar()
            : SizedBox(
                width: 0,
                height: 0,
              ),
      ],
    );
  }
}
