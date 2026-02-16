import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/profile/models/profile_params.dart';
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
  }
}

Future<void> _handleFollowNotification({required String uid}) async {
  final provider = ProviderContainer();
  provider.read(authNotifierProvider.notifier).listen();

  globalNavigationKey.currentContext?.goNamed(
    Paths.userProfile.name,
    extra: ProfileParams(uid: uid),
  );
}
