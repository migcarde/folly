import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

class RequestEntity extends Equatable {
  final String id;
  final UserEntity user;
  final UserEntity receiver;

  const RequestEntity({
    required this.id,
    required this.user,
    required this.receiver,
  });

  @override
  List<Object?> get props => [id, user, receiver];
}
