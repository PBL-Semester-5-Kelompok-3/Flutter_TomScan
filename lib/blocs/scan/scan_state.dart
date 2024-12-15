import 'package:equatable/equatable.dart';
import 'package:toma_scan/models/scan_model.dart';

abstract class ScanState extends Equatable {
  @override
  List<Object> get props => [];
}

class ScanInitial extends ScanState {}

class ScanLoading extends ScanState {}

class ScanLoaded extends ScanState {
  final ScanModel scanModel;

  ScanLoaded({required this.scanModel});

  @override
  List<Object> get props => [scanModel];
}

class ScanError extends ScanState {
  final String message;

  ScanError({required this.message});

  @override
  List<Object> get props => [message];
}

// Tambahkan state terkait history
class HistorySaving extends ScanState {}

class HistorySaved extends ScanState {}

class HistorySaveError extends ScanState {
  final String message;

  HistorySaveError({required this.message});

  @override
  List<Object> get props => [message];
}
