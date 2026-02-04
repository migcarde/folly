import 'package:data/core/network_errors/enums/network_error_code.dart';

class NetworkException implements Exception {
  final NetworkErrorCode code;
  final String? message;
  final StackTrace? stackTrace;

  const NetworkException({required this.code, this.message, this.stackTrace});
}
