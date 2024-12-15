import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/history/history_event.dart';
import 'package:toma_scan/blocs/history/history_state.dart';
import 'package:toma_scan/models/history_model.dart';
import 'package:toma_scan/services/history_service.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryService historyService;

  HistoryBloc({required this.historyService}) : super(HistoryInitialState());

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    if (event is LoadHistoriesEvent) {
      yield HistoryLoadingState();
      try {
        final histories = await historyService.getAllHistories();
        yield HistoryLoadedState(histories);
      } catch (e) {
        yield HistoryErrorState(e.toString());
      }
    }
  }
}
