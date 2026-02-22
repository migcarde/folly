enum AppMessagingTypes {
  challengeReminder,
  follow,
  comment,
  like,
  none;

  factory AppMessagingTypes.fromString(String type) {
    switch (type) {
      case 'challengeReminder':
        return AppMessagingTypes.challengeReminder;
      case 'follow':
        return AppMessagingTypes.follow;
      case 'comment':
        return AppMessagingTypes.comment;
      case 'like':
        return AppMessagingTypes.like;
      default:
        return AppMessagingTypes.none;
    }
  }
}
