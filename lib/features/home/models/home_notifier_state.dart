import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

enum HomeNotifierStatus { loading, success, error }

class HomeNotifierState extends Equatable {
  final HomeNotifierStatus status;
  final List<StoryEntity> stories;

  const HomeNotifierState({
    this.status = HomeNotifierStatus.loading,
    this.stories = const [],
  });

  @override
  List<Object?> get props => [status, stories];

  HomeNotifierState copyWith({
    HomeNotifierStatus? status,
    List<StoryEntity>? stories,
  }) {
    return HomeNotifierState(
      status: status ?? this.status,
      stories: stories ?? this.stories,
    );
  }
}
