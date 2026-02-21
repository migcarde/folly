enum NotificationType {
  like(value: 0, functionName: 'notify-firebase-on-like-create'),
  comment(value: 1, functionName: 'notify-firebase-on-comment-create'),
  follow(value: 2, functionName: 'notify-firebase-on-friend-create');

  final int value;
  final String functionName;

  const NotificationType({required this.value, required this.functionName});

  factory NotificationType.fromInt(int value) {
    switch (value) {
      case 0:
        return NotificationType.like;
      case 1:
        return NotificationType.comment;
      case 2:
        return NotificationType.follow;
      default:
        throw Exception('Unknown NotificationType: $value');
    }
  }
}
