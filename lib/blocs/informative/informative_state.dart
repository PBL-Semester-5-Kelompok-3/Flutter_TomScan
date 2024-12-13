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

// Pest And Disease State
// abstract class PestAndDiseaseState extends Equatable {
//   const PestAndDiseaseState();

//   @override
//   List<Object> get props => [];
// }

// class PestAndDiseaseInitial extends InformativeState {}

// class PestAndDiseaseLoading extends InformativeState {}

// class PestAndDiseaseSuccess extends InformativeState {
//   final List<PestAndDisease> pestAndDiseases;

//   const PestAndDiseaseSuccess(this.pestAndDiseases);

//   @override
//   List<Object> get props => [pestAndDiseases];
// }

// class PestAndDiseaseError extends InformativeState {
//   final String message;

//   const PestAndDiseaseError(this.message);

//   @override
//   List<Object> get props => [message];
// }
