import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/data/models/user_model.dart';
import 'package:packet_tea/data/services/apis/user_services.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserServices _userServices = GetIt.I.get<UserServices>();

  ProfileBloc() : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileFetchEvent) {
      yield* _fetchUserRecord(event);
    }
  }

  Stream<ProfileState> _fetchUserRecord(ProfileFetchEvent event) async* {
    yield ProfileInProgress();
    try {
      final UserModel user = await _userServices.fetchUserData();
      yield ProfileSuccess(user: user);
    } catch (error) {
      yield ProfileFailed();
    }
  }

}
