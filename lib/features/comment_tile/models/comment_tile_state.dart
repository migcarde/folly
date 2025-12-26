import 'package:domain/comments/models/comment_entity.dart';
import 'package:equatable/equatable.dart';

class CommentTileState extends Equatable {
  final List<CommentEntity> replies;
  final int page;
  final int totalPages;
  final int? total;

  const CommentTileState({
    this.replies = const [],
    this.page = 0,
    this.totalPages = 0,
    this.total,
  });

  CommentTileState copyWith({
    List<CommentEntity>? replies,
    int? page,
    int? totalPages,
    int? total,
  }) => CommentTileState(
    replies: replies ?? this.replies,
    page: page ?? this.page,
    totalPages: totalPages ?? this.totalPages,
    total: total ?? this.total,
  );

  @override
  List<Object?> get props => [replies, page, totalPages, total];

  bool get isLast => (page + 1) == totalPages;
}
