//lib/blocs/profile/profile_state.dart
part of 'profile_bloc.dart';

abstract class ProfileUpdateState {}

class ProfileUpdateInitial extends ProfileUpdateState {}

class ProfileUpdateLoading extends ProfileUpdateState {}

class ProfileUpdateSuccess extends ProfileUpdateState {}

class ProfileUpdateFailure extends ProfileUpdateState {
  final String error;

  ProfileUpdateFailure(this.error);
}