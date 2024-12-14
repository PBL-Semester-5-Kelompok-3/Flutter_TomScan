//lib/blocs/profile/profile_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/models/user_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  ProfileUpdateBloc() : super(ProfileUpdateInitial());

  @override
  Stream<ProfileUpdateState> mapEventToState(ProfileUpdateEvent event) async* {
    if (event is UpdateProfile) {
      yield ProfileUpdateLoading();
      try {
        // Simulate a network call or database update.
        await Future.delayed(Duration(seconds: 2));
        
        // Here you would typically call your API to update the profile
        // e.g., await ApiService.updateUserProfile(event.user);
        
        yield ProfileUpdateSuccess();
      } catch (error) {
        yield ProfileUpdateFailure(error.toString());
      }
    }
  }
}