import 'package:firebase_messaging/firebase_messaging.dart';

abstract class MessagingService {
  Future<void> showNotification(RemoteMessage message);
  Future<String?> getToken();
  Future<void> deleteToken();
}
