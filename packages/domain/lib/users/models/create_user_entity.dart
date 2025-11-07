import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

class CreateUserEntity extends Equatable {
  final String password;
  final UserEntity data;

  const CreateUserEntity({required this.password, required this.data});

  @override
  List<Object?> get props => [password, data];
}
