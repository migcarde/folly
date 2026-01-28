import 'package:domain/notifications/enums/notification_type.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/extensions/date_time_extensions.dart';
import 'package:folly/extensions/notification_extensions.dart';
import 'package:folly/widgets/profile_image.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    this.user,
    required this.date,
    required this.type,
    required this.isRead,
  });

  final UserEntity? user;
  final DateTime date;
  final NotificationType type;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;

    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.screenPadding,
          vertical: AppDimens.s,
        ),
        color: isRead
            ? Colors.transparent
            : theme.colorScheme.secondaryContainer,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppDimens.s,
                    bottom: AppDimens.s,
                  ),
                  child: user == null
                      ? Container(
                          width: 48.0,
                          height: 48.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.outlineVariant,
                            borderRadius: BorderRadius.circular(
                              AppDimens.circularRadius,
                            ),
                          ),
                          child: Icon(
                            PhosphorIcons.info(),
                            size: 48.0 * 0.6,
                            color: theme.primaryColor,
                          ),
                        )
                      : ProfileImage(imageUrl: user?.photoPath, size: 48.0),
                ),
                if (user != null)
                  Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(
                        AppDimens.circularRadius,
                      ),
                      border: Border.all(
                        color: type.getColor(theme: theme),
                        width: 2.0,
                      ),
                    ),
                    child: Icon(
                      type.icon,
                      size: AppDimens.m,
                      color: type.getColor(theme: theme),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: AppDimens.m),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: user?.username ?? '',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: ' ${type.getText(l10n: l10n).toLowerCase()}',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      date.getDateDiff(l10n: l10n),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
