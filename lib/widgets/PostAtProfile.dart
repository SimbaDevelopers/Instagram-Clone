import 'package:flutter/material.dart';

class PostAtProfile extends StatefulWidget {
  @override
  _PostAtProfileState createState() => _PostAtProfileState();
}

class _PostAtProfileState extends State<PostAtProfile>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(
            color: Colors.grey,
          ),
          Container(
            child: TabBar(tabs: [
              Tab(
                icon: Icon(Icons.apps),
              ),
              Tab(
                icon: Icon(Icons.assignment_ind),
              ),
            ]),
          ),
          Container(
            //Add this to give height
            height: MediaQuery.of(context).size.height,
            child: TabBarView(children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("           Posts....."),
                ),
              ),
              Container(
                decoration: BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("           Taged Posts......"),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
