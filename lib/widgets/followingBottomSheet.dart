import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:provider/provider.dart';

class FollowingBottmSheet extends StatefulWidget {

  UserModel user;
  Function decreaseFollowingsCount;
  FollowingBottmSheet({this.user , this.decreaseFollowingsCount});
  @override
  _FollowingBottmSheetState createState() => _FollowingBottmSheetState();
}

class _FollowingBottmSheetState extends State<FollowingBottmSheet> {


  unfollow() async {
    await Provider.of<UserInformation>(context , listen: false ).unfollow(widget.user.userId);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Divider(
                  indent: 160,
                  endIndent: 160,
                  thickness: 4,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'tejas.anghan',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Divider(
                  height: 35,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Add to Close Friend List',
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(
                          Icons.stars,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Notofications',
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Mute',
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Restrict',
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    unfollow();
                    widget.decreaseFollowingsCount();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'unfollow',
                    style:
                        TextStyle(color: Colors.deepPurple[400], fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 7,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
