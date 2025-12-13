import 'package:domain/comments/models/comment_entity.dart';
import 'package:equatable/equatable.dart';

enum CommentsStatus { loading, empty, data, error }

class CommentsState extends Equatable {
  final CommentsStatus status;
  final List<CommentEntity> comments;
  final int page;
  final int totalPages;
  final int? total;

  const CommentsState({
    this.status = CommentsStatus.loading,
    this.comments = const [],
    this.page = 0,
    this.totalPages = 0,
    this.total,
  });

  @override
  List<Object?> get props => [status, comments, page, totalPages, total];

  CommentsState copyWith({
    CommentsStatus? status,
    List<CommentEntity>? comments,
    int? page,
    int? totalPages,
    int? total,
  }) => CommentsState(
    status: status ?? this.status,
    comments: comments ?? this.comments,
    page: page ?? this.page,
    totalPages: totalPages ?? this.totalPages,
    total: total ?? this.total,
  );

  bool get isLast => (page + 1) == totalPages;
}
