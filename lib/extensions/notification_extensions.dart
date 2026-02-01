import 'package:domain/notifications/enums/notification_type.dart';
import 'package:flutter/material.dart';
import 'package:folly/l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension NotificationExtensions on NotificationType {
  String getText({required AppLocalizations l10n}) {
    switch (this) {
      case NotificationType.like:
        return l10n.likes_your_story;
      case NotificationType.comment:
        return l10n.comments_on_your_story;
      case NotificationType.follow:
        return l10n.is_following_you;
    }
  }

  IconData get icon {
    switch (this) {
      case NotificationType.like:
        return PhosphorIcons.heart(PhosphorIconsStyle.fill);
      case NotificationType.comment:
        return PhosphorIcons.chatCircle(PhosphorIconsStyle.fill);
      case NotificationType.follow:
        return PhosphorIcons.user(PhosphorIconsStyle.fill);
    }
  }

  Color getColor({required ThemeData theme}) {
    switch (this) {
      case NotificationType.like:
        return theme.colorScheme.error;
      case NotificationType.comment:
        return theme.colorScheme.scrim;
      case NotificationType.follow:
        return theme.colorScheme.primary;
    }
  }
}
