import 'package:folly/l10n/app_localizations.dart';

extension DateTimeExtensions on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999, 999);
  String getDateDiff({required AppLocalizations l10n}) {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 0) {
      return l10n.day(difference.inDays);
    } else if (difference.inHours > 0) {
      return l10n.hour(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return l10n.minute(difference.inMinutes);
    } else {
      return l10n.now;
    }
  }
}
