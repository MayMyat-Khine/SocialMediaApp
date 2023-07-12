import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/data/vos/user_vo.dart';
import 'package:social_media_app/network/data_agent.dart';

const usersPath = "users";
const fileUploadRef = "uploads";

class CloudFirestoreDataAgentImpl extends SocialDataAgent {
  final String _newFeedCollection = "newsfeed";
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  /// Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  /// Storage
  var firebaseStorage = FirebaseStorage.instance;

  @override
  Future<void> addNewPost(NewsFeedVO newPost) {
    return _firebaseFirestore
        .collection(_newFeedCollection)
        .doc(newPost.id.toString())
        .set(newPost.toJson());
  }

  @override
  Future<void> deletePost(String postId) {
    return _firebaseFirestore
        .collection(_newFeedCollection)
        .doc(postId)
        .delete();
  }

  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    return _firebaseFirestore
        .collection(_newFeedCollection)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map((document) {
        return NewsFeedVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Stream<NewsFeedVO> getNewsFeedById(int newFeedsId) {
    return _firebaseFirestore
        .collection(_newFeedCollection)
        .doc(newFeedsId.toString())
        .get()
        .asStream()
        .where((docSnapShot) => docSnapShot.data() != null)
        .map((docSnapShot) => NewsFeedVO.fromJson(docSnapShot.data()!));
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
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  Future logOut() {
    return auth.signOut();
  }

  @override
  Future login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
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
    return _firebaseFirestore
        .collection(usersPath)
        .doc(newUser.id.toString())
        .set(newUser.toJson());
  }

  @override
  Future<String> uploadFileToFirebase(File image) {
    return firebaseStorage
        .ref(fileUploadRef)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }
}
