part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginEmailChanged extends LoginEvent {
  final String username;

  const LoginEmailChanged({this.username});

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  final String pwd;

  const LoginPasswordChanged({this.pwd});

  @override
  List<Object> get props => [pwd];
}

class LogInSubmissionEvent extends LoginEvent{
  @override
  List<Object> get props =>[];

}