import 'package:firebase_database/firebase_database.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/data/vos/user_vo.dart';
import 'package:social_media_app/network/data_agent.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Database Paths
const newsFeedPath = 'newsfeed';
const usersPath = "users";

class RealTimeDatabaseDataAgentImpl extends SocialDataAgent {
  static final RealTimeDatabaseDataAgentImpl _singleton =
      RealTimeDatabaseDataAgentImpl._internal();

  factory RealTimeDatabaseDataAgentImpl() {
    return _singleton;
  }

  RealTimeDatabaseDataAgentImpl._internal();

  /// Database
  var databaseRef = FirebaseDatabase.instance.ref();

  /// Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    //
    // return databaseRef.child(newsFeedPath).onValue.map((event) {
    //   return (event.snapshot.value as Map<dynamic, dynamic>)
    //       .values
    //       .map<NewsFeedVO>((element) {
    //     return NewsFeedVO.fromJson(Map<String, dynamic>.from(element));
    //   }).toList();
    // });
    List<NewsFeedVO> newsList = [];
    return databaseRef.child(newsFeedPath).onValue.map((event) {
      newsList.clear();
      print(event.snapshot.value.runtimeType);
      // List<Object?> data = event.snapshot.value as List;
      Map<Object?, Object?> data =
          event.snapshot.value as Map<Object?, Object?>;
      for (int i = 0; i < data.entries.length; i++) {
        Map<Object?, Object?> dynamicMap = {};
        dynamicMap = data.values.elementAt(i) as Map<Object?, Object?>;
        Map<String, dynamic> stringMap = {};
        stringMap = dynamicMap.cast<String, dynamic>();
        Map<String, dynamic> castdata = {};
        stringMap.entries.forEach((e) {
          castdata[e.key] = e.value;
        });
        newsList.add(NewsFeedVO.fromJson(castdata));
      }
      return newsList;
    });
  }

  @override
  Future<void> addNewPost(NewsFeedVO newPost) {
    return databaseRef
        .child(newsFeedPath)
        .child(newPost.id.toString())
        .set(newPost.toJson());
  }

  @override
  Future<void> deletePost(String postId) {
    return databaseRef.child(newsFeedPath).child(postId.toString()).remove();
  }

  @override
  Stream<NewsFeedVO> getNewsFeedById(int newFeedsId) {
    return databaseRef
        .child(newsFeedPath)
        .child(newFeedsId.toString())
        .once()
        .asStream()
        .map((snapShot) {
      print(NewsFeedVO.fromJson(
        Map<String, dynamic>.from(
            snapShot.snapshot.value as Map<Object?, Object?>),
      ).userName);
      return NewsFeedVO.fromJson(
        Map<String, dynamic>.from(
            snapShot.snapshot.value as Map<Object?, Object?>),
      );
    });
  }

  @override
  Future registerNewUser(UserVO newUser) {
    return auth
        .createUserWithEmailAndPassword(
            email: newUser.email ?? "", password: newUser.password ?? "")
        .then((credential) =>
            credential.user?..updateDisplayName(newUser.userName))
        .then((user) {
      newUser.id = user?.uid ?? "";
      _addNewUser(newUser);
    });
  }

  Future<void> _addNewUser(UserVO newUser) {
    return databaseRef
        .child(usersPath)
        .child(newUser.id.toString())
        .set(newUser.toJson());
  }

  @override
  Future login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  UserVO getLoggedInUser() {
    return UserVO(
      id: auth.currentUser?.uid,
      email: auth.currentUser?.email,
      userName: auth.currentUser?.displayName,
    );
  }

  @override
  Future logOut() {
    return auth.signOut();
  }
}
