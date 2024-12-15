import 'package:equatable/equatable.dart';
import 'package:toma_scan/models/history_model.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitialState extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistoryLoadedState extends HistoryState {
  final List<History> histories;

  const HistoryLoadedState(this.histories);

  @override
  List<Object> get props => [histories];
}

class HistoryErrorState extends HistoryState {
  final String message;

  const HistoryErrorState(this.message);

  @override
  List<Object> get props => [message];
}
