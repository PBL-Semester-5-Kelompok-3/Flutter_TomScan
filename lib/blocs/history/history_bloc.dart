import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/history/history_event.dart';
import 'package:toma_scan/blocs/history/history_state.dart';
import 'package:toma_scan/services/history_service.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryService historyService;

  HistoryBloc({required this.historyService}) : super(HistoryInitialState()) {
    on<LoadHistoriesEvent>(_onLoadHistories);
  }

  Future<void> _onLoadHistories(
      LoadHistoriesEvent event, Emitter<HistoryState> emit) async {
    emit(HistoryLoadingState());
    try {
      final histories = await historyService.getAllHistories();
      emit(HistoryLoadedState(histories));
    } catch (error) {
      emit(HistoryErrorState(error.toString()));
    }
  }
}
