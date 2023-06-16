import 'package:social_media_app/data/vos/news_feed_vo.dart';

abstract class SocialModel {
  Stream<List<NewsFeedVO>> getNewsFeed();
  Stream<NewsFeedVO> getNewsFeedbyId(int newFeedsId);
  Future<void> addNewPost(String description);
  Future<void> editNewPost(NewsFeedVO vo);
  Future<void> deletePost(String postId);
}
