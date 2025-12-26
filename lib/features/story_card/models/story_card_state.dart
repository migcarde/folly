import 'package:domain/likes/models/like_entity.dart';
import 'package:equatable/equatable.dart';

class StoryCardState extends Equatable {
  final LikeEntity? like;
  final int likesCount;
  final int commentsCount;

  const StoryCardState({
    this.like,
    this.likesCount = 0,
    this.commentsCount = 0,
  });

  @override
  List<Object?> get props => [like, likesCount, commentsCount];

  StoryCardState copyWith({
    LikeEntity? like,
    int? likesCount,
    int? commentsCount,
  }) {
    return StoryCardState(
      like: like ?? this.like,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
    );
  }

  StoryCardState removeLike() =>
      StoryCardState(like: null, likesCount: likesCount - 1);
}
