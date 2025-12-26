class LikeRemoteEntity {
  final String id;
  final String uid;
  final String? storyId;
  final String? commentId;

  const LikeRemoteEntity({
    required this.id,
    required this.uid,
    this.storyId,
    this.commentId,
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    if (storyId != null) 'story_id': storyId,
    if (commentId != null) 'comment_id': commentId,
  };

  factory LikeRemoteEntity.fromJson({required Map<String, dynamic> json}) =>
      LikeRemoteEntity(
        id: json['id'],
        uid: json['uid'],
        storyId: json['story_id'],
        commentId: json['comment_id'],
      );
}
