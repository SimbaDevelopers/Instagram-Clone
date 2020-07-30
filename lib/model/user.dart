class UserModel {
  String userId;
  String username;
  String name;
  String bio;
  String website;
  String email;
  String profileImageURL;
  Map followingsMap;
  Map followersMap;
  List<Map> followingList;
  List<Map> followerList;
  int followersCount;
  int followingsCount;
  int postCount;

  UserModel({
    this.userId,
    this.username,
    this.name,
    this.bio,
    this.website,
    this.email,
    this.profileImageURL,
    this.followingsMap,
    this.followersMap,
    this.followerList,
    this.followingList,
    this.followersCount,
    this.followingsCount,
    this.postCount,
  });
  static UserModel fromMap({snapshot , followersList , followingsList }){
    return UserModel(
      username: snapshot['username'],
      name: snapshot['name'],
      bio : snapshot['bio'],
      website:  snapshot['website'],
      userId: snapshot['userId'],
      profileImageURL: snapshot['profileImageURL'].toString(),
      followerList: followersList,
      followersMap: snapshot['followersMap'] as Map,
      followingList: followingsList,
      followingsMap: snapshot['followingsMap'] as Map,
      followersCount: snapshot['followersCount'],
      followingsCount: snapshot['followingsCount'],
      postCount: snapshot['postCount']

    );
  }
}
