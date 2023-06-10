import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/network/data_agent.dart';

// Database Paths
const newsFeedPath = 'newsfeed';

class RealTimeDatabaseDataAgentImpl extends SocialDataAgent {
  static final RealTimeDatabaseDataAgentImpl _singleton =
      RealTimeDatabaseDataAgentImpl._internal();

  factory RealTimeDatabaseDataAgentImpl() {
    return _singleton;
  }

  RealTimeDatabaseDataAgentImpl._internal();

  /// Database
  var databaseRef = FirebaseDatabase.instance.ref();
  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    //
    // return databaseRef.child(newsFeedPath).onValue.map((event) {
    //   return (event.snapshot.value as Map<dynamic, dynamic>)
    //       .values
    //       .map<NewsFeedVO>((element) {
    //     return NewsFeedVO.fromJson(Map<String, dynamic>.from(element));
    //   }).toList();
    // });
    List<NewsFeedVO> newsList = [];
    return databaseRef.child(newsFeedPath).onValue.map((event) {
      List<Object?> data = event.snapshot.value as List;

      for (int i = 1; i < data.length; i++) {
        Map<Object?, Object?> dynamicMap = {};
        dynamicMap = data[i] as Map<Object?, Object?>;
        Map<String, dynamic> stringMap = {};
        stringMap = dynamicMap.cast<String, dynamic>();
        Map<String, dynamic> castdata = {};
        stringMap.entries.forEach((e) {
          castdata[e.key] = e.value;
        });
        newsList.add(NewsFeedVO.fromJson(castdata));
      }
      return newsList;
    });
  }
}
