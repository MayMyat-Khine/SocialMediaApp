import 'package:flutter/widgets.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/models/social_model.dart';
import 'package:social_media_app/models/social_model_impl.dart';

class AddNewPostBloc extends ChangeNotifier {
  /// State
  String newPostDescription = '';
  bool isAddNewPostError = false;
  bool isDisposed = false;
  bool isInEditMode = false;
  String userName = '';
  String profilePicture = '';
  NewsFeedVO? newsFeed;

  /// Model
  SocialModel _mSocialModel = SocialModelImpl();

  AddNewPostBloc({int? newFeedId}) {
    if (newFeedId != null) {
      isInEditMode = true;
      _prepopulateDataForEditMode(newFeedId);
    } else {
      _prepopulateDataForAddPost();
    }
  }
  void onNewPostTextChangedd(String description) {
    newPostDescription = description;
  }

  Future onTapAddNewPost({int? newFeedId}) {
    if (newPostDescription.isEmpty) {
      isAddNewPostError = true;
      if (!isDisposed) {
        notifyListeners();
      }
      return Future.error("error");
    } else {
      isAddNewPostError = false;
      if (isInEditMode) {
        return _editNewsFeedPost();
      } else {
        return _mSocialModel.addNewPost(newPostDescription);
      }
    }
  }

  Future<dynamic> _editNewsFeedPost() {
    newsFeed?.description = newPostDescription;
    if (newsFeed != null) {
      return _mSocialModel.editNewPost(newsFeed!);
    } else {
      return Future.error("error");
    }
  }

  void _prepopulateDataForAddPost() {
    userName = "Mmk";
    profilePicture =
        "https://upload.wikimedia.org/wikipedia/commons/0/0f/IU_posing_for_Marie_Claire_Korea_March_2022_issue_03.jpg";
    notifyListeners();
  }

  void _prepopulateDataForEditMode(int newFeedId) {
    _mSocialModel.getNewsFeedbyId(newFeedId).listen((event) {
      userName = event.userName ?? "";
      profilePicture = event.profilePicture ?? "";
      newPostDescription = event.description ?? "";
      newsFeed = event;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}