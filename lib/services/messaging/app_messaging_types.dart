enum AppMessagingTypes {
  challengeReminder,
  follow,
  none;

  factory AppMessagingTypes.fromString(String type) {
    switch (type) {
      case 'challengeReminder':
        return AppMessagingTypes.challengeReminder;
      case 'follow':
        return AppMessagingTypes.follow;
      default:
        return AppMessagingTypes.none;
    }
  }
}
