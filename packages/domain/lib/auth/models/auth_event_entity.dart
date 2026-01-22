import 'package:domain/auth/enums/auth_event_status.dart';
import 'package:domain/auth/models/auth_entity.dart';

class AuthEventEntity {
  final AuthEventStatus status;
  final AuthEntity? auth;

  AuthEventEntity({required this.status, this.auth});
}
