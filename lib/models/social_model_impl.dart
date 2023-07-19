import 'dart:io';

import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/models/auth_model_impl.dart';
import 'package:social_media_app/models/social_model.dart';
import 'package:social_media_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:social_media_app/network/data_agent.dart';
import 'package:social_media_app/network/realtime_db_data_agent_impl.dart';

class SocialModelImpl extends SocialModel {
  static final SocialModelImpl _singleton = SocialModelImpl._internal();

  factory SocialModelImpl() {
    return _singleton;
  }

  SocialModelImpl._internal();

  SocialDataAgent mDataAgent = RealTimeDatabaseDataAgentImpl();
  // SocialDataAgent mDataAgent = CloudFirestoreDataAgentImpl();

  final _authModel = AuthenticationModelImpl();
  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    return mDataAgent.getNewsFeed();
  }

  @override
  Future<void> addNewPost(String description, File? imageFile) {
    if (imageFile != null) {
      return mDataAgent
          .uploadFileToFirebase(imageFile)
          .then((downloadUrl) => craftNewsFeedVO(description, downloadUrl))
          .then((newPost) => mDataAgent.addNewPost(newPost));
    } else {
      return craftNewsFeedVO(description, "")
          .then((newPost) => mDataAgent.addNewPost(newPost));
    }
  }

  Future<NewsFeedVO> craftNewsFeedVO(String description, String imageUrl) {
    var currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    var newPost = NewsFeedVO(
      id: currentMilliseconds,
      userName: _authModel.getLoggedInUser().userName,
      postImage: imageUrl,
      description: description,
      profilePicture:
          'https://upload.wikimedia.org/wikipedia/commons/0/0f/IU_posing_for_Marie_Claire_Korea_March_2022_issue_03.jpg',
    );
    return Future.value(newPost);
  }

  @override
  Future<void> deletePost(String postId) {
    return mDataAgent.deletePost(postId);
  }

  @override
  Stream<NewsFeedVO> getNewsFeedbyId(int newFeedsId) {
    return mDataAgent.getNewsFeedById(newFeedsId);
  }

  @override
  Future<void> editNewPost(NewsFeedVO vo) {
    return mDataAgent.addNewPost(vo);
  }
}
