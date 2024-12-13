part of 'informative_bloc.dart';

abstract class InformativeState extends Equatable {
  const InformativeState();

  @override
  List<Object> get props => [];
}

class InformativeInitial extends InformativeState {}

class InformativeLoading extends InformativeState {}

class InformativeSuccess extends InformativeState {
  final List<Informative> informatives;

  const InformativeSuccess(this.informatives);

  @override
  List<Object> get props => [informatives];
}

class InformativeError extends InformativeState {
  final String message;

  const InformativeError(this.message);

  @override
  List<Object> get props => [message];
}
