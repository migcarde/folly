import 'package:folly/routes/go_router_config.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/services/messaging/app_messaging_types.dart';
import 'package:go_router/go_router.dart';

Future<void> manageMessage(Map<String, dynamic> message) async {
  final type = AppMessagingTypes.fromString(message['type']);
  switch (type) {
    case AppMessagingTypes.challengeReminder:
      break;
    case AppMessagingTypes.none:
      break;
    case AppMessagingTypes.follow:
      break;
    case AppMessagingTypes.comment:
      break;
    case AppMessagingTypes.like:
      break;
  }
}

Future<void> handleTapNotification({
  required Map<String, dynamic> message,
}) async {
  final type = AppMessagingTypes.fromString(message['type']);
  switch (type) {
    case AppMessagingTypes.challengeReminder:
      break;
    case AppMessagingTypes.none:
      break;
    case AppMessagingTypes.follow:
      final String uid = message['uid'];

      await _handleFollowNotification(uid: uid);
      break;
    case AppMessagingTypes.comment:
    case AppMessagingTypes.like:
      final storyId = message['storyId'];

      await _handleCommentNotification(storyId: storyId);
      break;
  }
}

Future<void> _handleFollowNotification({required String uid}) async {
  globalNavigationKey.currentContext?.goNamed(
    Paths.userProfile.name,
    pathParameters: {'id': uid},
  );
}

Future<void> _handleCommentNotification({required String storyId}) async {
  globalNavigationKey.currentContext?.goNamed(Paths.story.name, extra: storyId);
}
