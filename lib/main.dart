import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_app/network/realtime_db_data_agent_impl.dart';
import 'package:social_media_app/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // RealTimeDatabaseDataAgentImpl db = RealTimeDatabaseDataAgentImpl();
  // db.getNewsFeed().listen((event) {
  //   print(event);
  // });
  // // db.getNewsFeed().listen((newsFeedList) {
  // //   print(newsFeedList.toString());
  // //   // newsFeed = newsFeedList;
  // //   // if (!isDisposed) {
  // //   //   notifyListeners();
  // //   // }
  // // });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.ubuntu().fontFamily),
      home: const HomePage(),
    );
  }
}
