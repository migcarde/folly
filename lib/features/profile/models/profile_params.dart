import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

class ProfileParams extends Equatable {
  final String? uid;
  final UserEntity? user;

  const ProfileParams({this.uid, this.user})
    : assert(
        uid != null || user != null,
        'Either uid or user must be provided',
      );

  @override
  List<Object?> get props => [uid, user];
}
