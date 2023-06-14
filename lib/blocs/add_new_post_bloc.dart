import 'package:flutter/widgets.dart';
import 'package:social_media_app/models/social_model.dart';
import 'package:social_media_app/models/social_model_impl.dart';

class AddNewPostBloc extends ChangeNotifier {
  /// State
  String newPostDescription = '';
  bool isAddNewPostError = false;
  bool isDisposed = false;

  /// Model
  SocialModel _mSocialModel = SocialModelImpl();

  void onNewPostTextChangedd(String description) {
    newPostDescription = description;
  }

  Future onTapAddNewPost() {
    if (newPostDescription.isEmpty) {
      isAddNewPostError = true;
      if (!isDisposed) {
        notifyListeners();
      }
      return Future.error("error");
    } else {
      isAddNewPostError = false;
      return _mSocialModel.addNewPost(newPostDescription);
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
