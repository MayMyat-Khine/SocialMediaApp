import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCMService {
  static final FCMService _singleton = FCMService._internal();

  factory FCMService() {
    return _singleton;
  }

  FCMService._internal();

  /// Firebase Messaging Instance
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  void listenForMessages() {
    messaging.getToken().then((fcmToken) {
      debugPrint("FCM Token for Device ======> $fcmToken");
    });
  }
}
