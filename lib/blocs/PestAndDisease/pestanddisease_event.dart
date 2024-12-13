part of 'pestanddisease_bloc.dart';

abstract class PestanddiseaseEvent extends Equatable {
  const PestanddiseaseEvent();

  @override
  List<Object> get props => [];
}

abstract class PestAndDiseaseEvent extends Equatable {
  const PestAndDiseaseEvent();

  @override
  List<Object> get props => [];
}

class FetchPestAndDiseases extends PestAndDiseaseEvent {}
