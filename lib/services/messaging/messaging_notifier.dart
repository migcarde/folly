import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/services/messaging/message_handlers.dart';
import 'package:folly/services/messaging/messaging_service.dart';
import 'package:logging_service/logging_service.dart';

class MessagingNotifier extends AsyncNotifier<void>
    implements MessagingService {
  final _log = LoggingService.getLogger('MessagingNotifier');
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
      onDidReceiveBackgroundNotificationResponse: openNotification,
      onDidReceiveNotificationResponse: (details) {
        _log.logInfo(
          title: 'Notification response',
          message: 'Details: $details',
        );

        openNotification(details);
      },
    );

    await FirebaseMessaging.instance.requestPermission(
      provisional: true,
      sound: true,
      badge: true,
      alert: true,
    );

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      await _onTapBackgroundMessage(initialMessage);
    }

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
      _log.info('APNS Token: $apnsToken');

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
        payload: jsonEncode(message.data),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'com.micadeb.folly',
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
    _log.logInfo(
      title: 'Received foreground message',
      message: 'Message: $message',
    );
    showNotification(message);
    await manageMessage(message.data);
  }

  Future<void> _onTapBackgroundMessage(RemoteMessage message) async {
    _log.logInfo(
      title: 'On tap background message',
      message: 'Message: $message',
    );

    handleTapNotification(message: message.data);
  }
}

@pragma('vm:entry-point')
Future<void> _onReceiveBackgroundMessage(RemoteMessage message) async {
  final log = LoggingService.getLogger('MessagingBackgroundHandler');
  log.logInfo(
    title: 'Received foreground message',
    message: 'Message: $message',
  );
  await Firebase.initializeApp();
  // TODO: Initialize injection here
  manageMessage(message.data);
}

@pragma('vm:entry-point')
void openNotification(NotificationResponse notificationResponse) {
  if (notificationResponse.payload != null &&
      notificationResponse.payload!.isNotEmpty) {
    final log = LoggingService.getLogger('MessagingBackgroundHandler');
    log.logInfo(
      title: 'Open notification',
      message: 'Payload: ${notificationResponse.payload}',
    );

    handleTapNotification(message: jsonDecode(notificationResponse.payload!));
  }
}

final messagingNotifierProvider =
    AsyncNotifierProvider<MessagingNotifier, void>(() => MessagingNotifier());
