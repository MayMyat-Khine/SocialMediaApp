import 'package:flutter/material.dart';
import 'package:social_media_app/blocs/newsfeed_bloc.dart';
import 'package:social_media_app/pages/add_new_post_page.dart';
import 'package:social_media_app/resources/dimens.dart';
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
            )
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
