import 'package:domain/auth/enums/auth_event_status.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final AuthEventStatus status;
  final UserEntity? user;

  const AuthState({this.status = AuthEventStatus.none, this.user});

  @override
  List<Object?> get props => [status, user];
}
