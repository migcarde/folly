import 'package:data/remote/stories/models/story_remote_entity.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

class StoryEntity extends Equatable {
  final String id;
  final UserEntity user;
  final String title;
  final String imageUrl;
  final DateTime createdAt;
  final int likes;
  final String challenge;

  const StoryEntity({
    required this.id,
    required this.user,
    required this.title,
    required this.imageUrl,
    required this.createdAt,
    required this.likes,
    required this.challenge,
  });

  @override
  List<Object?> get props => [
    id,
    user,
    title,
    imageUrl,
    createdAt,
    likes,
    challenge,
  ];
}

extension StoryRemoteEntityExtensions on StoryRemoteEntity {
  StoryEntity toEntity({required UserEntity user, required String challenge}) {
    return StoryEntity(
      id: id,
      user: user,
      title: title,
      imageUrl: filePath,
      createdAt: DateTime.parse(createdAt),
      likes: likes,
      challenge: challenge,
    );
  }
}
