import 'package:domain/likes/models/like_entity.dart';
import 'package:equatable/equatable.dart';

class CommentState extends Equatable {
  final LikeEntity? like;
  final int likesCount;

  const CommentState({this.like, this.likesCount = 0});

  @override
  List<Object?> get props => [like, likesCount];

  CommentState copyWith({LikeEntity? like, int? likesCount}) {
    return CommentState(
      like: like ?? this.like,
      likesCount: likesCount ?? this.likesCount,
    );
  }

  CommentState removeLike() =>
      CommentState(like: null, likesCount: likesCount - 1);
}
