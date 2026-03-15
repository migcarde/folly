import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

enum ReportUserStaus {
  none,
  success,
  failure;

  bool get isSuccess => this == ReportUserStaus.success;
  bool get isFailure => this == ReportUserStaus.failure;
}

enum ReportUserError { descriptionEmpty, mediaEmpty }

class ReportUserState extends Equatable {
  final ReportUserStaus status;
  final List<ReportUserError> errors;
  final XFile? media;

  const ReportUserState({
    this.status = ReportUserStaus.none,
    this.errors = const [],
    this.media,
  });

  @override
  List<Object?> get props => [status, errors, media];

  ReportUserState copyWith({
    ReportUserStaus? status,
    List<ReportUserError>? errors,
    XFile? media,
  }) => ReportUserState(
    status: status ?? this.status,
    errors: errors ?? this.errors,
    media: media ?? this.media,
  );
}
