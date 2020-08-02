import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class ImageBubble extends StatelessWidget {
  ImageBubble(this.context,this.imgurl,this.isMe,this.userimg);

  final BuildContext context;
  final String imgurl,userimg;
  final bool isMe;
  @override
  Widget build(BuildContext context) { print(imgurl);
    final size = MediaQuery.of(context).size;
    return Stack(children: <Widget>[
      Positioned(top: 18,
        child:
        CircleAvatar(
          backgroundImage:isMe ? null : userimg==null ? AssetImage('assets/images/profile.jpeg') : NetworkImage(userimg),),),
      Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: size.height * 0.3,
            width: size.width * 0.45,
            margin: isMe? EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 10,
            ) : EdgeInsets.only(
                left: 45,
                right: 16,
                top: 5,
                bottom:5
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(imgurl),
                  )),
            ),
          ),
        ],
      ),
    ],

    );
  }
}
