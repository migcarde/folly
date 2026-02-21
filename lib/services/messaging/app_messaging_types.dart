enum AppMessagingTypes {
  challengeReminder,
  follow,
  comment,
  none;

  factory AppMessagingTypes.fromString(String type) {
    switch (type) {
      case 'challengeReminder':
        return AppMessagingTypes.challengeReminder;
      case 'follow':
        return AppMessagingTypes.follow;
      case 'comment':
        return AppMessagingTypes.comment;
      default:
        return AppMessagingTypes.none;
    }
  }
}
