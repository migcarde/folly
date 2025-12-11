import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

enum FeedNotifierStatus { loading, success, error }

class FeedNotifierState extends Equatable {
  final FeedNotifierStatus status;
  final List<StoryEntity> stories;
  final int page;
  final int totalPages;
  final int? total;

  const FeedNotifierState({
    this.status = FeedNotifierStatus.loading,
    this.stories = const [],
    this.page = 0,
    this.totalPages = 0,
    this.total,
  });

  @override
  List<Object?> get props => [status, stories, page, totalPages, total];

  FeedNotifierState copyWith({
    FeedNotifierStatus? status,
    List<StoryEntity>? stories,
    int? page,
    int? totalPages,
    int? total,
  }) => FeedNotifierState(
    status: status ?? this.status,
    stories: stories ?? this.stories,
    page: page ?? this.page,
    totalPages: totalPages ?? this.totalPages,
    total: total ?? this.total,
  );

  bool get isLast => (page + 1) >= totalPages;
}
