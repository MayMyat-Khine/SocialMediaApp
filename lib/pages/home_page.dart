import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/blocs/add_new_post_bloc.dart';
import 'package:social_media_app/blocs/newsfeed_bloc.dart';
import 'package:social_media_app/pages/add_new_post_page.dart';
import 'package:social_media_app/pages/login_page.dart';
import 'package:social_media_app/pages/test_page.dart';
import 'package:social_media_app/resources/dimens.dart';
import 'package:social_media_app/utils/extensions.dart';
import 'package:social_media_app/viewitems/news_feed_item_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsfeedBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // throw Exception();
            // FirebaseCrashlytics.instance.crash();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddNewPostPage()));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Container(
            margin: const EdgeInsets.only(
              left: MARGIN_MEDIUM,
            ),
            child: const Text(
              "Social",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: TEXT_HEADING_1X,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                /// TODO : - Handle Search Here
              },
              child: Container(
                margin: const EdgeInsets.only(
                  right: MARGIN_LARGE,
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: MARGIN_LARGE,
                ),
              ),
            ),
            Consumer<NewsfeedBloc>(
              builder: (context, bloc, child) => GestureDetector(
                onTap: () {
                  bloc.onTapLogout().then(
                      (_) => navigateToScreen(context, const LoginPage()));
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    right: MARGIN_LARGE,
                  ),
                  child: const Icon(
                    Icons.logout,
                    color: Colors.red,
                    size: MARGIN_LARGE,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(
            color: Colors.white,
            child: Consumer(
              builder: (BuildContext context, NewsfeedBloc _newsfeedBloc,
                      Widget? child) =>
                  ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: MARGIN_LARGE,
                  horizontal: MARGIN_LARGE,
                ),
                itemBuilder: (context, index) {
                  return NewsFeedItemView(
                    newsfeed: _newsfeedBloc.newsfeedList[index],
                    onTapDelete: () {
                      _newsfeedBloc.deletePost(
                          _newsfeedBloc.newsfeedList[index].id.toString());
                    },
                    onTapEdit: () {
                      // AddNewPostBloc(
                      //     newFeedId: _newsfeedBloc.newsfeedList[index].id ?? 0);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => AddNewPostPage(
                      //         newsFeedId:
                      //             _newsfeedBloc.newsfeedList[index].id ?? 0)));

                      Future.delayed(const Duration(milliseconds: 1000))
                          .then((value) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddNewPostPage(
                                  newsFeedId:
                                      _newsfeedBloc.newsfeedList[index].id,
                                )));
                        // _navigateToEditPostPage(context, newsFeedId);
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: MARGIN_XLARGE,
                  );
                },
                itemCount: _newsfeedBloc.newsfeedList.length,
              ),
            )),
      ),
    );
  }
}
