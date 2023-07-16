import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

const String remoteConfigThemeColor = "theme_color";

class FirebaseRemoteConfiguration {
  static final FirebaseRemoteConfiguration _singleton =
      FirebaseRemoteConfiguration._internal();

  factory FirebaseRemoteConfiguration() {
    return _singleton;
  }

  FirebaseRemoteConfiguration._internal() {
    initializeRemoteConfig();
    _remoteConfig.fetchAndActivate();
  }

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  /// remote config setting initialize ///
  void initializeRemoteConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 1),
      minimumFetchInterval: const Duration(seconds: 1),
    ));
  }

  MaterialColor getThemeColorFromRemoteConfig() {
    debugPrint(
        "Remote Config Theme Color Value ======> ${_remoteConfig.getString(remoteConfigThemeColor)}");
    return MaterialColor(
      int.parse(_remoteConfig.getString(remoteConfigThemeColor)),
      const {},
    );
  }
}
