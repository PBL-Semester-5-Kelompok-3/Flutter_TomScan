import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:toma_scan/models/informatifs_model.dart';
import 'package:toma_scan/services/informatif_service.dart';

part 'pestanddisease_event.dart';
part 'pestanddisease_state.dart';

// pest_and_disease_bloc.dart
class PestAndDiseaseBloc
    extends Bloc<PestAndDiseaseEvent, PestAndDiseaseState> {
  final InformatifsService informatifsService;

  PestAndDiseaseBloc(this.informatifsService) : super(PestAndDiseaseInitial()) {
    on<FetchPestAndDiseases>(_onFetchPestAndDiseases);
  }

  Future<void> _onFetchPestAndDiseases(
      FetchPestAndDiseases event, Emitter<PestAndDiseaseState> emit) async {
    try {
      emit(PestAndDiseaseLoading());
      final pestAndDiseases =
          await informatifsService.getAllPestAndDiseaseData();
      emit(PestAndDiseaseSuccess(pestAndDiseases));
    } catch (e) {
      emit(PestAndDiseaseError(e.toString()));
    }
  }
}
