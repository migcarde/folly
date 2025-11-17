import 'package:equatable/equatable.dart';

enum UploadStoryStatus {
  initial,
  loading,
  success,
  error;

  bool get isLoading => this == UploadStoryStatus.loading;
}

class UploadStoryState extends Equatable {
  final UploadStoryStatus status;
  final bool titleIsEmpty;

  const UploadStoryState({
    this.status = UploadStoryStatus.initial,
    this.titleIsEmpty = false,
  });

  @override
  List<Object?> get props => [status, titleIsEmpty];

  UploadStoryState copyWith({UploadStoryStatus? status, bool? titleIsEmpty}) =>
      UploadStoryState(
        status: status ?? this.status,
        titleIsEmpty: titleIsEmpty ?? this.titleIsEmpty,
      );
}
