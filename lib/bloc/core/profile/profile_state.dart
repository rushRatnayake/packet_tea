part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileInProgress extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileSuccess extends ProfileState {
  final UserModel user;

  const ProfileSuccess({this.user});

  @override
  List<Object> get props => [user];
}

class ProfileFailed extends ProfileState {
  @override
  List<Object> get props => [];
}