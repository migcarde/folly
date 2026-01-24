enum AppMessagingTypes {
  challengeReminder,
  none;

  factory AppMessagingTypes.fromString(String type) {
    switch (type) {
      case 'challengeReminder':
        return AppMessagingTypes.challengeReminder;
      default:
        return AppMessagingTypes.none;
    }
  }
}
