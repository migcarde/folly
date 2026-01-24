import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/services/messaging/app_messaging_types.dart';
import 'package:folly/services/messaging/message_handlers.dart';
import 'package:folly/services/messaging/messaging_service.dart';

class MessagingNotifier extends AsyncNotifier<void>
    implements MessagingService {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  FutureOr<void> build() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (Platform.isAndroid) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    } else if (Platform.isIOS) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions();
    }

    await _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      ),
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: (details) {
        debugPrint('notification response: $details');
      },
    );

    await FirebaseMessaging.instance.requestPermission(
      provisional: true,
      sound: true,
      badge: true,
      alert: true,
    );

    FirebaseMessaging.onMessage.listen(_onRecieveForegroundMessage);
    FirebaseMessaging.onBackgroundMessage(_onReceiveBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(
      (remoteMessage) async => await _onTapBackgroundMessage(remoteMessage),
    );
  }

  @override
  Future<void> deleteToken() async =>
      await FirebaseMessaging.instance.deleteToken();

  @override
  Future<String?> getToken() async {
    if (Platform.isIOS) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      debugPrint('APNS Token: $apnsToken');

      if (apnsToken != null) {
        return FirebaseMessaging.instance.getToken();
      } else {
        return null;
      }
    } else {
      return FirebaseMessaging.instance.getToken();
    }
  }

  @override
  Future<void> showNotification(RemoteMessage message) =>
      _flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecond,
        message.notification?.title,
        message.notification?.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'com.bamboo.birthdayReminder',
            'push_notification',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true,
          ),
          iOS: DarwinNotificationDetails(
            presentSound: true,
            presentAlert: true,
            presentBanner: true,
            presentList: true,
          ),
        ),
      );

  Future<void> _onRecieveForegroundMessage(RemoteMessage message) async {
    debugPrint('onReceiveForegroundMessage: $message');
    showNotification(message);
    await manageMessage(message.data);
  }

  Future<void> _onTapBackgroundMessage(RemoteMessage message) async {
    debugPrint('onMessageOpenedApp: $message');
    final type = AppMessagingTypes.fromString(message.data['type']);

    switch (type) {
      case AppMessagingTypes.challengeReminder:
        // TODO: Handle challenge reminder
        break;
      case AppMessagingTypes.none:
        break;
    }
  }
}

@pragma('vm:entry-point')
Future<void> _onReceiveBackgroundMessage(RemoteMessage message) async {
  debugPrint('onReceiveBackgroundMessage: $message');
  await Firebase.initializeApp();
  // TODO: Initialize injection here
  manageMessage(message.data);
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  debugPrint('notificationTapBackground: $notificationResponse');
}

final messagingNotifierProvider =
    AsyncNotifierProvider<MessagingNotifier, void>(() => MessagingNotifier());
