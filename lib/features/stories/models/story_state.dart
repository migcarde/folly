import 'package:domain/comments/models/comment_entity.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class StoryState extends Equatable {
  final StoryEntity story;
  final List<CommentEntity> comments;
  final int page;
  final int totalPages;
  final int? total;
  final CommentEntity? commentToReply;

  const StoryState({
    required this.story,
    required this.comments,
    this.page = 0,
    this.totalPages = 0,
    this.total,
    this.commentToReply,
  });

  StoryState copyWith({
    StoryEntity? story,
    List<CommentEntity>? comments,
    int? page,
    int? totalPages,
    int? total,
    CommentEntity? commentToReply,
  }) => StoryState(
    story: story ?? this.story,
    comments: comments ?? this.comments,
    page: page ?? this.page,
    totalPages: totalPages ?? this.totalPages,
    total: total ?? this.total,
    commentToReply: commentToReply ?? this.commentToReply,
  );

  @override
  List<Object?> get props => [
    story,
    comments,
    page,
    totalPages,
    total,
    commentToReply,
  ];

  bool get isLast => (page + 1) == totalPages;
}
