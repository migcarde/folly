import 'package:domain/comments/models/comment_entity.dart';
import 'package:equatable/equatable.dart';

enum CommentsErrorMessages { createCommentError, deleteCommentError, none }

class CommentsState extends Equatable {
  final bool commentIsSending;
  final CommentsErrorMessages error;
  final List<CommentEntity> comments;
  final int page;
  final int totalPages;
  final int? total;
  final CommentEntity? commentToReply;

  const CommentsState({
    this.commentIsSending = false,
    this.error = CommentsErrorMessages.none,
    this.comments = const [],
    this.page = 0,
    this.totalPages = 0,
    this.total,
    this.commentToReply,
  });

  @override
  List<Object?> get props => [
    commentIsSending,
    error,
    comments,
    page,
    totalPages,
    total,
    commentToReply,
  ];

  CommentsState copyWith({
    bool? commentIsSending,
    CommentsErrorMessages? error,
    List<CommentEntity>? comments,
    int? page,
    int? totalPages,
    int? total,
    CommentEntity? commentToReply,
  }) => CommentsState(
    commentIsSending: commentIsSending ?? this.commentIsSending,
    error: error ?? this.error,
    comments: comments ?? this.comments,
    page: page ?? this.page,
    totalPages: totalPages ?? this.totalPages,
    total: total ?? this.total,
    commentToReply: commentToReply ?? this.commentToReply,
  );

  CommentsState clearCommentToReply() => CommentsState(
    commentIsSending: commentIsSending,
    error: error,
    comments: comments,
    page: page,
    totalPages: totalPages,
    total: total,
    commentToReply: null,
  );

  bool get isLast => (page + 1) == totalPages;
}
