import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:toma_scan/models/informatif_model.dart';
import 'package:toma_scan/services/informatif_service.dart';

part 'informatif_event.dart';
part 'informatif_state.dart';

class InformatifsBloc extends Bloc<InformatifsEvent, InformatifsState> {
  final InformatifsService _informatifsService;

  InformatifsBloc(this._informatifsService) : super(InformatifsInitialState()) {
    on<GetAllInformatifsEvent>(_onGetAllInformatifsEvent);
    on<GetInformatifsEvent>(_onGetInformatifsEvent);
    on<CreateInformatifsEvent>(_onCreateInformatifsEvent);
    on<UpdateInformatifsEvent>(_onUpdateInformatifsEvent);
    on<DeleteInformatifsEvent>(_onDeleteInformatifsEvent);
  }

  Future<void> _onGetAllInformatifsEvent(
      GetAllInformatifsEvent event, Emitter<InformatifsState> emit) async {
    try {
      emit(InformatifsLoadingState());
      final informatifsData = await _informatifsService.getAllInformatifsData();
      emit(InformatifsSuccessState(informatifsData));
    } catch (e) {
      emit(InformatifsErrorState(e.toString()));
    }
  }

  Future<void> _onGetInformatifsEvent(
      GetInformatifsEvent event, Emitter<InformatifsState> emit) async {
    try {
      emit(InformatifsLoadingState());
      final informatifsData =
          await _informatifsService.getInformatifsData(event.id);
      emit(InformatifsSuccessState([informatifsData]));
    } catch (e) {
      emit(InformatifsErrorState(e.toString()));
    }
  }

  Future<void> _onCreateInformatifsEvent(
      CreateInformatifsEvent event, Emitter<InformatifsState> emit) async {
    try {
      emit(InformatifsLoadingState());
      await _informatifsService.createInformatifsData(event.informatifsData);
      final informatifsData = await _informatifsService.getAllInformatifsData();
      emit(InformatifsSuccessState(informatifsData));
    } catch (e) {
      emit(InformatifsErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateInformatifsEvent(
      UpdateInformatifsEvent event, Emitter<InformatifsState> emit) async {
    try {
      emit(InformatifsLoadingState());
      await _informatifsService.updateInformatifsData(
          event.id, event.informatifsData);
      final informatifsData = await _informatifsService.getAllInformatifsData();
      emit(InformatifsSuccessState(informatifsData));
    } catch (e) {
      emit(InformatifsErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteInformatifsEvent(
      DeleteInformatifsEvent event, Emitter<InformatifsState> emit) async {
    try {
      emit(InformatifsLoadingState());
      await _informatifsService.deleteInformatifsData(event.id);
      final informatifsData = await _informatifsService.getAllInformatifsData();
      emit(InformatifsSuccessState(informatifsData));
    } catch (e) {
      emit(InformatifsErrorState(e.toString()));
    }
  }
}
