//lib/blocs/profile/profile_event.dart
part of 'profile_bloc.dart';


abstract class ProfileUpdateEvent {}

class UpdateProfile extends ProfileUpdateEvent {
  final UserModel user;

  UpdateProfile(this.user);
}