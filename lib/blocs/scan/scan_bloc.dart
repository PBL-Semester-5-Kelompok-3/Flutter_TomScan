import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/scan/scan_event.dart';
import 'package:toma_scan/blocs/scan/scan_state.dart';
import 'package:toma_scan/services/scan_service.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final ScanService scanService;

  ScanBloc({required this.scanService}) : super(ScanInitial()) {
    on<SaveHistoryEvent>((event, emit) async {
      emit(HistorySaving());
      try {
        // Assume saveHistory is a method in ScanService to save history
        await scanService.saveHistory(
          userId: event.userId,
          diseaseId: event.diseaseId,
          label: event.label,
          imagePath: event.imagePath,
        );
        emit(HistorySaved());
      } catch (e) {
        emit(HistorySaveError(message: e.toString()));
      }
    });
  }
}
