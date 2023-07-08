import 'package:flutter/widgets.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/models/auth_model.dart';
import 'package:social_media_app/models/auth_model_impl.dart';
import 'package:social_media_app/models/social_model.dart';
import 'package:social_media_app/models/social_model_impl.dart';

class NewsfeedBloc extends ChangeNotifier {
  List<NewsFeedVO> newsfeedList = [];
  SocialModel _mSocialModel = SocialModelImpl();
  final AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();

  bool isDisposed = false;
  NewsfeedBloc() {
    _mSocialModel.getNewsFeed().listen((newsFeed) {
      newsfeedList = newsFeed;
      if (!isDisposed) {
        notifyListeners();
      }
    });
  }
  Future<void> deletePost(String postId) {
    return _mSocialModel.deletePost(postId);
  }

  Future onTapLogout() {
    return _mAuthenticationModel.logOut();
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
