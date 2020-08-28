import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class StoryScreen extends StatefulWidget {
  static const routeName = 'StoryScreen';

  StoryScreen({Key key}) : super(key: key);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  var docSnap;
  var storyIndex;
  var stories;
  var maxIndex;
  var storyList = [];
  UserModel currentUser = null;
  PageController _pageController;
  AnimationController _animationController;
  int _currentIndex = 0;
  bool k = true;
  bool isStoped = false;
  bool videoLoading = true;

  VideoPlayerController _videoPlayerController;

  Future<Null> setAnimationController() {
    if (k && !(currentUser==null) ) {
      setState(() {

        addToStoryList(timeStamp , storyUrl , storyType , imageOrVideo , duration) {
          String timestamp =
          timeStamp.toDate().toString();
          final year = int.parse(timestamp.substring(0, 4));
          final month = int.parse(timestamp.substring(5, 7));
          final day = int.parse(timestamp.substring(8, 10));
          final hour = int.parse(timestamp.substring(11, 13));
          final minute = int.parse(timestamp.substring(14, 16));

          final DateTime videoDate = DateTime(year, month, day, hour, minute);
          final int diffInHours = DateTime.now().difference(videoDate).inHours;

          String timeAgo = '';
          String timeUnit = '';
          int timeValue = 0;
          if (diffInHours < 24) {
            if (diffInHours < 1) {
              final diffInMinutes =
                  DateTime.now().difference(videoDate).inMinutes;
              timeValue = diffInMinutes;
              timeUnit = 'm';
            } else if (diffInHours < 24) {
              timeValue = diffInHours;
              timeUnit = 'h';
            }
            timeAgo = timeValue.toString() + timeUnit;
        //    print(storyList[i]);
            storyList.add({
              'timeAgo': timeAgo,
              'storyURL': storyUrl,
              "storyType" : storyType,
              'imageOrVideo' : imageOrVideo,
              'duration' : duration
            });
          }
        }

        for (int i = 0; i < docSnap['File'].length; i++) {
          if(docSnap['File'][i]['storyType'] == "CloseFriends" && currentUser.whoAddedUinCFsMap.containsKey(docSnap['userId']) ){
            addToStoryList(docSnap['File'][i]['timeStamp'] , docSnap['File'][i]['storyURL'], docSnap['File'][i]['storyType'], docSnap['File'][i]['imageOrVideo'] ,docSnap['File'][i]['duration']);
          }
          else if(docSnap['File'][i]['storyType'] == "story"){
            addToStoryList(docSnap['File'][i]['timeStamp'] ,docSnap['File'][i]['storyURL'], docSnap['File'][i]['storyType'],  docSnap['File'][i]['imageOrVideo'],docSnap['File'][i]['duration']);
          }
        }
      });
      k = false;
      // load the fist story
      _loadStory(story: storyList[_currentIndex], animateToPage: false);

      _animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.stop();
          _animationController.reset();
          setState(() {
            if (_currentIndex + 1 < storyList.length) {
              _currentIndex += 1;
              _loadStory(story: storyList[_currentIndex]);
            } else {
              // Navigator pop
//            _currentIndex=0;
//            _loadStory(story : storyList[_currentIndex]);
              if (storyIndex < maxIndex - 1) {
                Navigator.pushReplacementNamed(
                    context, StoryScreen.routeName + 'Left Swipe',
                    arguments: {
                      'storyMap': stories[storyIndex + 1],
                      'storyIndex': storyIndex + 1,
                      'stories': stories,
                      'maxIndex': maxIndex
                    });
              } else {
                Navigator.of(context).pop();
              }
            }
          });
        }
      });
    }
  }

  @override
  void initState() {
    _pageController = PageController();
    _animationController = AnimationController(vsync: this);
  //  currentUser = Provider.of<UserInformation>(context , listen: false).user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    docSnap = arguments['storyMap'];
    storyIndex = arguments['storyIndex'];
    stories = arguments['stories'];
    maxIndex = arguments['maxIndex'];
    if(currentUser== null){
        currentUser = Provider.of<UserInformation>(context , listen: true).user;
    }

    return Scaffold(
        backgroundColor: Colors.black,
        body: /*Consumer <UserInformation>(
          builder: (context , userInfo , child){
            if(userInfo.user == null)
              return SizedBox();
            currentUser = userInfo.user;

            return */FutureBuilder(
            future: setAnimationController(),
            builder: (context, snap) {
              return GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0) {
                    // Right Swipe
                    if (storyIndex > 0)
                      Navigator.pushReplacementNamed(
                          context, StoryScreen.routeName + 'Right Swipe',
                          arguments: {
                            'storyMap': stories[storyIndex - 1],
                            'storyIndex': storyIndex - 1,
                            'stories': stories,
                            'maxIndex': maxIndex
                          });
                  } else if (details.delta.dx < 0) {
                    //Left Swipe
                    if (storyIndex < maxIndex - 1)
                      Navigator.pushReplacementNamed(
                          context, StoryScreen.routeName + 'Left Swipe',
                          arguments: {
                            'storyMap': stories[storyIndex + 1],
                            'storyIndex': storyIndex + 1,
                            'stories': stories,
                            'maxIndex': maxIndex
                          });
                    else
                      Navigator.of(context).pop();
                  }
                },
                onLongPressEnd: (details) {
                  if (isStoped) {
                    setState(() {
                      _animationController.forward();
                      isStoped = !isStoped;
                    });
                  } else {
                    setState(() {
                      _animationController.stop();
                      isStoped = !isStoped;
                    });
                  }
                },
                onTapDown: (details) => _onTapDown(details, docSnap),
                child: Stack(
                  children: <Widget>[
                    PageView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      itemCount: storyList.length,
                      itemBuilder: (context, i) {
                        switch(storyList[i]['imageOrVideo']){
                          case "Image" :
                            return CachedNetworkImage(
                                placeholder: (context, url) {
                                  return Center(child: Text('dasdsadsadasd'));
                                },
                                imageUrl: storyList[i]['storyURL'],
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) {
                                  if (downloadProgress.progress != null) {
                                    print(downloadProgress.progress);
                                    downloadProgress.progress < 1
                                        ? _animationController.stop()
                                        : _animationController.forward();
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  );
                                });
                          case 'Video' :
                            if(videoLoading){
                              return Center(child:  CircularProgressIndicator(),);
                            }
                            if(_videoPlayerController !=null  && _videoPlayerController.value.initialized){
                              return FittedBox(
                                fit: BoxFit.cover,
                                child: SizedBox(
                                  width: _videoPlayerController.value.size.width,
                                  height: _videoPlayerController.value.size.height,
                                  child: VideoPlayer(_videoPlayerController),
                                ),
                              );
                            }

                        }
                        return SizedBox.shrink();

                      },
                    ),
                    Positioned(
                      top: 20,
                      left: 10,
                      right: 10,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: storyList
                                .asMap()
                                .map((i, e) {
                                  return MapEntry(
                                    i,
                                    AnimatedBar(
                                      animationController: _animationController,
                                      position: i,
                                      currentIndex: _currentIndex,
                                    ),
                                  );
                                })
                                .values
                                .toList(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.5, vertical: 10),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage: CachedNetworkImageProvider(
                                      docSnap['profileImageURL']),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  docSnap['username'] + "  ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Expanded(
                                  child: Text(
                                    storyList[_currentIndex]['timeAgo'] != null
                                        ? storyList[_currentIndex]['timeAgo']
                                        : "",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            15 /*, fontWeight: FontWeight.w600*/),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    storyList[_currentIndex]['storyType'] == "CloseFriends" ? Positioned(
                      bottom: 10 ,
                      left: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.stars , size: 30,  color: Colors.white,),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Close Friends //<-only for Testing",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ) : SizedBox(),
                  ],
                ),
              );
            },
          ),

//      ),
        );
  }

  _onTapDown(TapDownDetails details, _onTapDown) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadStory(story: storyList[_currentIndex]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentIndex + 1 < storyList.length) {
          _currentIndex += 1;
          _loadStory(story: storyList[_currentIndex]);
        } else {
          // Navigator pop
//          _currentIndex=0;
//          _loadStory(story : storyList[_currentIndex]);
          if (storyIndex < maxIndex - 1)
            Navigator.pushReplacementNamed(
                context, StoryScreen.routeName + 'Left Swipe',
                arguments: {
                  'storyMap': stories[storyIndex + 1],
                  'storyIndex': storyIndex + 1,
                  'stories': stories,
                  'maxIndex': maxIndex
                });
          else
            Navigator.of(context).pop();
        }
      });
    } else {
      // if Video then play and puse
      if (isStoped) {
        setState(() {
          _animationController.forward();
          _videoPlayerController.play();
          isStoped = !isStoped;
        });
      } else {
        setState(() {
          _animationController.stop();
          _videoPlayerController.pause();
          isStoped = !isStoped;
        });
      }
    }
  }

  void _loadStory({story, bool animateToPage = true}) {
    _animationController.stop();
    _animationController.reset();
    if(_videoPlayerController!=null)
    _videoPlayerController.pause();

    if(story['imageOrVideo'] == 'Image') {
      _animationController.duration = Duration(seconds: 5);
      _animationController.forward();
    }
    else {
      setState(() {
        videoLoading = true;
      });
    _animationController.duration = Duration(milliseconds: story['duration'].toInt());
       _videoPlayerController = VideoPlayerController.network(story['storyURL'])..initialize().then((value) => setState((){
        videoLoading = false;
         _animationController.forward();
       }))..play();
    }



    if (animateToPage) {
      _pageController.animateToPage(_currentIndex,
          duration: const Duration(milliseconds: 1), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    _animationController.dispose();
    _videoPlayerController.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}

class AnimatedBar extends StatelessWidget {
  final animationController;
  final position;
  final currentIndex;

  AnimatedBar({
    Key key,
    this.animationController,
    this.currentIndex,
    this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(builder: (context, constrains) {
          return Stack(
            children: <Widget>[
              _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5)),
              position == currentIndex
                  ? AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return _buildContainer(
                            constrains.maxWidth * animationController.value,
                            Colors.white);
                      },
                    )
                  : SizedBox.shrink()
            ],
          );
        }),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 2,
      width: width,
      decoration: BoxDecoration(
          color: color,
//        border: Border.all(
//          color: Colors.black26,
//          width: 0.8,
//        ),
          borderRadius: BorderRadius.circular(3.0)),
    );
  }
}
