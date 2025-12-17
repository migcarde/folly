import 'package:domain/comments/models/comment_entity.dart';
import 'package:equatable/equatable.dart';

enum CommentsErrorMessages { createCommentError, deleteCommentError, none }

class CommentsState extends Equatable {
  final CommentsErrorMessages error;
  final List<CommentEntity> comments;
  final int page;
  final int totalPages;
  final int? total;

  const CommentsState({
    this.error = CommentsErrorMessages.none,
    this.comments = const [],
    this.page = 0,
    this.totalPages = 0,
    this.total,
  });

  @override
  List<Object?> get props => [error, comments, page, totalPages, total];

  CommentsState copyWith({
    CommentsErrorMessages? error,
    List<CommentEntity>? comments,
    int? page,
    int? totalPages,
    int? total,
  }) => CommentsState(
    error: error ?? this.error,
    comments: comments ?? this.comments,
    page: page ?? this.page,
    totalPages: totalPages ?? this.totalPages,
    total: total ?? this.total,
  );

  bool get isLast => (page + 1) == totalPages;
}
