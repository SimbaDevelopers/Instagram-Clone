
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/PostList.dart';
import 'package:provider/provider.dart';
import '../widgets/CommentsListTile.dart';

//class CommentsScreen extends StatefulWidget {
//  static const routeName = '/CommentsScreen';
//  @override
//  _CommentsScreenState createState() => _CommentsScreenState();
//}

class CommentsScreen extends StatefulWidget {
  static const routeName = '/CommentsScreen';

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  var ctx;

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  var arguments;
  UserModel currentUser;
  String postId;
  String ownerId;
  var stream;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  undoComment(commentsMap , postId ) async
  {
    _scaffoldkey.currentState.hideCurrentSnackBar();
    _scaffoldkey.currentState.showSnackBar(new SnackBar(
      content: new Text("Deleted    " , style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.blueGrey,
      action: SnackBarAction(
        label: 'UNDO',
        textColor: Colors.white,
        onPressed: ()async {  await Provider.of<PostList>(context , listen: false).undoComment(commentsMap, postId);},
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    arguments = ModalRoute.of(context).settings.arguments as Map;
    postId = arguments['postId'];
    currentUser = arguments['user'];
    ownerId = arguments['ownerId'];
    stream = Firestore.instance.collection('posts').document(postId).collection('comments').orderBy('timeStamp' ,descending: false).snapshots();

    return Scaffold(
      key: _scaffoldkey,
        appBar: AppBar(
          title: Text('Comments'),
          actions: <Widget>[Icon(Icons.send)],
        ),
        body: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
//            List<Map> commentsList = [];
//            snapshot.data.documents.forEach((doc) {
//              commentsList.add(doc.data);
//            });
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (ctx, index) {
                  return CommentListTile(
                    key: UniqueKey(),
                      commentsMap: snapshot.data.documents[index].data, user: currentUser , postId : postId , ownerId :ownerId ,undoComment :undoComment );
                });
          },
        ),
    );
  }
}
