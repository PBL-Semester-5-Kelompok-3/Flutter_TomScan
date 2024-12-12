part of 'informatif_bloc.dart';

abstract class InformatifsEvent extends Equatable {
  const InformatifsEvent();

  @override
  List<Object> get props => [];
}

class GetAllInformatifsEvent extends InformatifsEvent {}

class GetInformatifsEvent extends InformatifsEvent {
  final int id;

  const GetInformatifsEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CreateInformatifsEvent extends InformatifsEvent {
  final InformatifsModel informatifsData;

  const CreateInformatifsEvent(this.informatifsData);

  @override
  List<Object> get props => [informatifsData];
}

class UpdateInformatifsEvent extends InformatifsEvent {
  final int id;
  final InformatifsModel informatifsData;

  const UpdateInformatifsEvent(this.id, this.informatifsData);

  @override
  List<Object> get props => [id, informatifsData];
}

class DeleteInformatifsEvent extends InformatifsEvent {
  final int id;

  const DeleteInformatifsEvent(this.id);

  @override
  List<Object> get props => [id];
}