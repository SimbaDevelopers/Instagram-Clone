import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Chats/database_chat.dart';
import 'package:instagram/helper/constants.dart';

import '../utils/settings.dart';

class CallPage extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String channelName;

  /// non-modifiable client role of the page
  final ClientRole role;
final String touserId;
  /// Creates a call page with given channel name.
  const CallPage({Key key, this.channelName, this.role,this.touserId}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  Timer _timer0;
  DataBaseService dataBaseService = new DataBaseService();
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
int called=0;
  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initialize();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Video Calling is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = Size(1920, 1080);
    await AgoraRtcEngine.setVideoEncoderConfiguration(configuration);
    await AgoraRtcEngine.joinChannel(null, widget.channelName, null, 0);

//    setState(() {
//    Firestore.instance.collection('users').document(Constants.uid).get().then((value) async {
//      if(value["Onvideocall"]==0){
//        _onCallEnd(context);
//        print("aaaaaaaaaaaaaaaaaaaaaasssssssssssssssss");
//      }
//    });
//    });

  }


  Future<void> _initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(APP_ID);
    await AgoraRtcEngine.enableVideo();
    await AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await AgoraRtcEngine.setClientRole(widget.role);
  }


  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
      int uid,
      int width,
      int height,
      int elapsed,
    ) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    };
  }


  List<Widget> _getRenderViews() {
    final List<AgoraRenderWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(AgoraRenderWidget(0, local: true, preview: true));
    }
    _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
    return list;
  }


  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }


  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }


  Widget _viewRows() {
    final views = _getRenderViews();
    if(views.length>1){
      called=1;
    }
if(views.length==1){
//  Firestore.instance.collection('users').document(Constants.uid).get().then((value) {
//    if(value["Onvideocall"]==0){
//      _onCallEnd(context);
//      print("aaaaaaaaaaaaaaaaaaaaaasssssssssssssssss");
//    }
//  });

int _counter=15;
Timer _timer;

_timer = Timer.periodic(Duration(seconds: 1), (timer) {
  if(mounted && called==0){
  setState(() {
    if(_counter > 0){
      _counter--;
    }else{
      _timer.cancel();
      _onCallEnd(context);
    //  print("aaaaaaaaaaaaaaaaaaaaaasssssssssssssssssqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");

    }
  });
  }else{

  }
        });
       }else{



}
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]])
          ],
        ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        ));
      default:
    }
    return Container();
  }


  Widget _toolbar() {
    final views = _getRenderViews();
    if (widget.role == ClientRole.Audience) return Container();
    return Column(children: <Widget>[
      Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 0),
            ),
//          RawMaterialButton(
//           // onPressed: ,
//            child: Icon(
//              Icons.grid_on,
//              size: 25.0,
//            ),
//          //  shape: CircleBorder(),
//            elevation: 2.0,
//            //   fillColor: muted ? Colors.blueAccent : Colors.white,
//            padding: const EdgeInsets.only(right: 25),
//          ),
            RawMaterialButton(
              onPressed: () => _onCallEnd(context),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 30.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              //    fillColor: Colors.redAccent,
              padding: const EdgeInsets.only(right: 80),
            ),
            RawMaterialButton(
              //   onPressed: ,
              child: Icon(
                Icons.videocam,
                size: 25.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              //   fillColor: muted ? Colors.blueAccent : Colors.white,
              padding: const EdgeInsets.only(right: 0),
            ),
            RawMaterialButton(
              onPressed: _onToggleMute,
              child: Icon(
                muted ? Icons.mic_off : Icons.mic,
                //  color: muted ? Colors.white : Colors.blueAccent,
                size: 25.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              //   fillColor: muted ? Colors.blueAccent : Colors.white,
              padding: const EdgeInsets.only(right: 0),
            ),
            RawMaterialButton(
              onPressed: _onSwitchCamera,
              child: Icon(
                Icons.switch_camera,
                //  color: Colors.blueAccent,
                size: 25.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              // fillColor: Colors.white,
              padding: const EdgeInsets.only(right: 15),
            ),

          ],
        ),
      ),
     views.length==1 ? Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Padding(padding: EdgeInsets.only(top: 100),),
            Text("Ringing...",style: TextStyle(fontSize: 30),)
          ],
        ),
      ) : Container(
       child: Text(""),
     )
    ],
    );
  }


  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return null;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onCallEnd(BuildContext context) async {
    Navigator.pop(context);
    _timer0.cancel();
    final dbRef = FirebaseDatabase.instance.reference().child("users");
    dbRef.child(widget.touserId).set({
      "Onvideocall":"0",
    });

  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(),
           // _panel(),
            _toolbar(),
          ],
        ),
      ),
    );
  }
}
