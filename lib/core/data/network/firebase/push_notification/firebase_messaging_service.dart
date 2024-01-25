import 'dart:convert';
import 'dart:io';
import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../../utils/app_log.dart';
import '../../../model/fcm/fcm_data.dart';
import 'notification_service.dart';

/// For handling the background notifications
Future _firebaseMessagingBackgroundHandler(RemoteMessage remoteMessage) async {
  AppLog.i("Handling a background message: ${remoteMessage.notification?.title}");
  FirebaseMessagingService().handleRemoteNotification(remoteMessage);
}

class FirebaseMessagingService {
  static const viewBody = 'view_body';
  static const actionFromFCM = 'action_from_fcm';
  static const backgroundBody = 'background_body';

  static final FirebaseMessagingService _firebaseMessagingService =
      FirebaseMessagingService._internal();

  factory FirebaseMessagingService() {
    return _firebaseMessagingService;
  }

  FirebaseMessagingService._internal();

  void requestAndRegisterNotification() async {
    try {
      /// Instantiate Firebase Messaging
      final FirebaseMessaging messaging = FirebaseMessaging.instance;

      if (kIsWeb) {
      } else if (Platform.isAndroid) {
        String? fcmToken = await messaging.getToken();
        AppLog.i('FCM token is $fcmToken');
      } else if (Platform.isIOS) {
        /// On iOS, this helps to take the user permissions
        NotificationSettings settings = await messaging.requestPermission(
          alert: true,
          badge: true,
          provisional: false,
          sound: true,
        );
        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          AppLog.i('User granted permission');
          String? fcmToken = await messaging.getToken();
          AppLog.i('FCM token is: $fcmToken');
        } else {
          AppLog.i('User declined or has not accepted permission');
        }
      }

      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        /// TODO: If necessary send token to application server.
        /// Note: This callback is fired at each app startup and whenever a new
        AppLog.i('FCM token is refreshed: $fcmToken');
      }).onError((err) {
        /// Error getting token.
      });

      /// For handling the foreground notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
        AppLog.i('onMessage - ${remoteMessage.notification?.title} ${remoteMessage.data.toString()}');
        handleRemoteNotification(remoteMessage);
      });

      /// For handling the notification tap
      FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
        AppLog.i('onMessageOpenedApp - ${remoteMessage.notification?.title} ${remoteMessage.data.toString()}');
        NotificationService().handleBackgroundNotificationAction(remoteMessage);
      });

      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      await NotificationService().init();
      NotificationService().requestPermissions();
    } catch (e, st) {
      AppLog.e('requestAndRegisterNotification : ${e.toString()} \n${st.toString()}');
    }
  }

  Future<void> handleRemoteNotification(RemoteMessage remoteMessage) async {
    FCMData fcmData = getFDCMData(remoteMessage);
    NotificationService().showNotification(fcmData);
  }

  FCMData getFDCMData(RemoteMessage remoteMessage) {
    FCMData fcmData = FCMData(title: remoteMessage.notification?.title ?? '', message: remoteMessage.notification?.body ?? '');
    if (remoteMessage.data[viewBody] != null) {
      FCMViewBody fcmViewBody =
          FCMViewBody.fromJson(json.decode(remoteMessage.data[viewBody]));
      fcmData.viewBody = fcmViewBody;
    } else if (remoteMessage.data[backgroundBody] != null) {
      FCMViewBody fcmViewBody = FCMViewBody();
      fcmData.viewBody = fcmViewBody;
    }
    return fcmData;
  }

  Future<String?> getFCMToken() async {
    /// Instantiate Firebase Messaging
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    if (kIsWeb) {
    } else if (Platform.isAndroid) {
      String? fcmToken = await messaging.getToken();
      AppLog.i('FCM token is $fcmToken');
      return fcmToken;
    } else if (Platform.isIOS) {
      /// On iOS, this helps to take the user permissions
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        AppLog.i('User granted permission');
        String? fcmToken = await messaging.getToken();
        AppLog.i('FCM token is: $fcmToken');
        return fcmToken;
      } else {
        AppLog.i('User declined or has not accepted permission');
      }
    }
    return null;
  }
}
