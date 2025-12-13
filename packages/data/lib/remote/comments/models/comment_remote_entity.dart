class CommentRemoteEntity {
  final String id;
  final String text;
  final String storyId;
  final String uid;
  final String? parentCommentId;

  const CommentRemoteEntity({
    required this.id,
    required this.text,
    required this.storyId,
    required this.uid,
    this.parentCommentId,
  });

  factory CommentRemoteEntity.fromJson({required Map<String, dynamic> json}) {
    return CommentRemoteEntity(
      id: json['id'],
      text: json['text'],
      storyId: json['story_id'],
      uid: json['uid'],
      parentCommentId: json['parent_comment_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'story_id': storyId,
    'user_id': uid,
    if (parentCommentId != null) 'parent_comment_id': parentCommentId,
  };
}
