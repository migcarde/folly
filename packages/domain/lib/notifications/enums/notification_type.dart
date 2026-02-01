enum NotificationType {
  like(value: 0),
  comment(value: 1),
  follow(value: 2);

  final int value;

  const NotificationType({required this.value});

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
