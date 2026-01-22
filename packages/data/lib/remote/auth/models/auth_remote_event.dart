import 'package:data/data.dart';
import 'package:equatable/equatable.dart';

class AuthRemoteEvent extends Equatable {
  final AuthRemoteEventStatus status;
  final AuthRemoteEntity? user;

  const AuthRemoteEvent({required this.status, this.user});

  @override
  List<Object?> get props => [status, user];
}
