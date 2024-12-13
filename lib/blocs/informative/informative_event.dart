part of 'informative_bloc.dart';

abstract class InformativeEvent extends Equatable {
  const InformativeEvent();

  @override
  List<Object> get props => [];
}

class FetchInformatives extends InformativeEvent {}

abstract class PestAndDiseaseEvent extends Equatable {
  const PestAndDiseaseEvent();

  @override
  List<Object> get props => [];
}

class FetchPestAndDiseases extends InformativeEvent {}
