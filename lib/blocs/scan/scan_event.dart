// scan_event.dart
import 'package:equatable/equatable.dart';

abstract class ScanEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchScanDetails extends ScanEvent {
  final String disease;

  FetchScanDetails({required this.disease});

  @override
  List<Object> get props => [disease];
}

class SaveHistoryEvent extends ScanEvent {
  final int userId;
  final int diseaseId;
  final String label;
  final String imagePath;

  SaveHistoryEvent({
    required this.userId,
    required this.diseaseId,
    required this.label,
    required this.imagePath,
  });

  @override
  List<Object> get props => [userId, diseaseId, label, imagePath];
}

//BuAT
