import 'package:social_media_app/data/vos/news_feed_vo.dart';

abstract class SocialDataAgent {
  Stream<List<NewsFeedVO>> getNewsFeed();
  Stream<NewsFeedVO> getNewsFeedById(int newFeedsId);
  Future<void> addNewPost(NewsFeedVO newPost);
  Future<void> deletePost(String postId);
}
