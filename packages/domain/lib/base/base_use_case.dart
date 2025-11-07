import 'package:domain/base/result.dart';
import 'package:equatable/equatable.dart';

abstract class BaseUseCase<T, Params> {
  Future<Result<T>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
