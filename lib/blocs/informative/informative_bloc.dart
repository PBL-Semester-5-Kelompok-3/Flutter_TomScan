import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:toma_scan/models/informatifs_model.dart';
import 'package:toma_scan/services/informatif_service.dart';

part 'informative_event.dart';
part 'informative_state.dart';

class InformativeBloc extends Bloc<InformativeEvent, InformativeState> {
  final InformatifsService informatifsService;

  InformativeBloc(this.informatifsService) : super(InformativeInitial()) {
    on<FetchInformatives>((event, emit) async {
      try {
        emit(InformativeLoading());
        final informatives = await informatifsService.getAllInformatifsData();
        emit(InformativeSuccess(informatives));
      } catch (e) {
        if (e.toString().contains('Token expired')) {
          emit(const InformativeError('Session expired, logging out...'));
        } else {
          emit(InformativeError(e.toString()));
        }
      }
    });
  }
}
