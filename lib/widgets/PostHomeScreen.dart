import 'package:flutter/material.dart';
import 'package:instagram/widgets/Post.dart';

class PostHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Post();
        },
      ),
    );
  }
}
