import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/models/social_model.dart';
import 'package:social_media_app/network/data_agent.dart';
import 'package:social_media_app/network/realtime_db_data_agent_impl.dart';

class SocialModelImpl extends SocialModel {
  static final SocialModelImpl _singleton = SocialModelImpl._internal();

  factory SocialModelImpl() {
    return _singleton;
  }

  SocialModelImpl._internal();

  SocialDataAgent mDataAgent = RealTimeDatabaseDataAgentImpl();
  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    return mDataAgent.getNewsFeed();
  }
}
