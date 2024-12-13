part of 'pestanddisease_bloc.dart';

// pest_and_disease_state.dart
abstract class PestAndDiseaseState extends Equatable {
  const PestAndDiseaseState();

  @override
  List<Object> get props => [];
}

class PestAndDiseaseInitial extends PestAndDiseaseState {}

class PestAndDiseaseLoading extends PestAndDiseaseState {}

class PestAndDiseaseSuccess extends PestAndDiseaseState {
  final List<PestAndDisease> pestAndDiseases;

  const PestAndDiseaseSuccess(this.pestAndDiseases);

  @override
  List<Object> get props => [pestAndDiseases];
}

class PestAndDiseaseError extends PestAndDiseaseState {
  final String message;

  const PestAndDiseaseError(this.message);

  @override
  List<Object> get props => [message];
}
