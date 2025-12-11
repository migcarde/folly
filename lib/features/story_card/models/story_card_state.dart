import 'package:domain/likes/models/like_entity.dart';
import 'package:equatable/equatable.dart';

class StoryCardState extends Equatable {
  final LikeEntity? like;
  final int likesCount;

  const StoryCardState({this.like, this.likesCount = 0});

  @override
  List<Object?> get props => [like, likesCount];

  StoryCardState copyWith({LikeEntity? like, int? likesCount}) {
    return StoryCardState(
      like: like ?? this.like,
      likesCount: likesCount ?? this.likesCount,
    );
  }

  StoryCardState removeLike() =>
      StoryCardState(like: null, likesCount: likesCount - 1);
}
