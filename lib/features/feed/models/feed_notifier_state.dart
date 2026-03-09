import 'package:domain/feed/models/feed_entity.dart';
import 'package:equatable/equatable.dart';

enum FeedNotifierStatus { loading, success, error, empty }

class FeedNotifierState extends Equatable {
  final FeedNotifierStatus status;
  final List<FeedEntity> feed;
  final int page;
  final int totalPages;
  final int? total;

  const FeedNotifierState({
    this.status = FeedNotifierStatus.loading,
    this.feed = const [],
    this.page = 0,
    this.totalPages = 0,
    this.total,
  });

  @override
  List<Object?> get props => [status, feed, page, totalPages, total];

  FeedNotifierState copyWith({
    FeedNotifierStatus? status,
    List<FeedEntity>? feed,
    int? page,
    int? totalPages,
    int? total,
  }) => FeedNotifierState(
    status: status ?? this.status,
    feed: feed ?? this.feed,
    page: page ?? this.page,
    totalPages: totalPages ?? this.totalPages,
    total: total ?? this.total,
  );

  bool get isLast => (page + 1) >= totalPages;
}
