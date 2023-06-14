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

  @override
  Future<void> addNewPost(String description) {
    var currentMilliseconds = DateTime.now().millisecond;
    var newPost = NewsFeedVO(
        id: currentMilliseconds,
        userName: "MMK",
        postImage:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Retriever_in_water.jpg/168px-Retriever_in_water.jpg",
        description: description,
        profilePicture:
            'https://upload.wikimedia.org/wikipedia/commons/0/0f/IU_posing_for_Marie_Claire_Korea_March_2022_issue_03.jpg');
    return mDataAgent.addNewPost(newPost);
  }
}
