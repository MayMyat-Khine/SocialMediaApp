import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/network/data_agent.dart';

class CloudFirestoreDataAgentImpl extends SocialDataAgent {
  final String _newFeedCollection = "newsfeed";
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<void> addNewPost(NewsFeedVO newPost) {
    // TODO: implement addNewPost
    throw UnimplementedError();
  }

  @override
  Future<void> deletePost(String postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
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
    // TODO: implement getNewsFeedById
    throw UnimplementedError();
  }
}
