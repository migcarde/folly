import 'package:equatable/equatable.dart';

class Failure<T> extends Result<T> {
  final Object failure;
  final StackTrace stackTrace;

  const Failure({required this.failure, required this.stackTrace}) : super._();

  @override
  List<Object?> get props => [failure, stackTrace];
}

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data) : super._();

  @override
  List<Object?> get props => [data];
}

class Result<T> extends Equatable {
  const Result._();

  factory Result.success(T result) => Success<T>(result);
  factory Result.failure(Object failure) =>
      Failure(failure: failure, stackTrace: StackTrace.current);

  W when<W>(
    W Function(T result) success,
    W Function(Object failure, StackTrace stackTrace) failure,
  ) {
    if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else {
      return failure(
        (this as Failure<T>).failure,
        (this as Failure<T>).stackTrace,
      );
    }
  }

  void ifSuccess(Function(T) success) {
    if (this is Success<T>) {
      success((this as Success<T>).data);
    }
  }

  @override
  List<Object?> get props => [];
}
