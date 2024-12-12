part of 'informatif_bloc.dart';

abstract class InformatifsState extends Equatable {
  const InformatifsState();

  @override
  List<Object> get props => [];
}

class InformatifsInitialState extends InformatifsState {}

class InformatifsLoadingState extends InformatifsState {}

class InformatifsSuccessState extends InformatifsState {
  final List<InformatifsModel> informatifsData;

  const InformatifsSuccessState(this.informatifsData);

  @override
  List<Object> get props => [informatifsData];
}

class InformatifsErrorState extends InformatifsState {
  final String error;

  const InformatifsErrorState(this.error);

  @override
  List<Object> get props => [error];
}
