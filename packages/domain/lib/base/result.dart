import 'package:equatable/equatable.dart';

class Failure<T> extends Result<T> {
  final Object failure;

  const Failure(this.failure) : super._();

  @override
  List<Object?> get props => [
        failure,
      ];
}

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data) : super._();

  @override
  List<Object?> get props => [
        data,
      ];
}

class Result<T> extends Equatable {
  const Result._();

  factory Result.success(T result) => Success<T>(result);
  factory Result.failure(Object failure) => Failure(failure);

  void when(Function(T) success, Function(Object) failure) {
    if (this is Success<T>) {
      success((this as Success<T>).data);
    } else if (this is Failure<T>) {
      failure((this as Failure<T>).failure);
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
