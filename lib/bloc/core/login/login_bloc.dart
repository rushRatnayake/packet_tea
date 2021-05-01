import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/data/services/apis/user_services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserServices _userServices = GetIt.I.get<UserServices>();

  LoginBloc() : super(LoginState());

  static LoginState createInitialState(){
    return LoginState(
        username: "",
        password: "",
        status: FormzStatus.invalid
    );
  }

  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event,
      ) async* {
    if(event is LogInSubmissionEvent){
      yield* _mapLogInFormSubmissionEToS(event);
    }else  if (event is LoginEmailChanged){
      yield* _mapUsernameChangedEToS(event);
    }else if(event is LoginPasswordChanged){
      yield* _mapPasswordChangedEToS(event);
    }
  }
  Stream<LoginState> _mapUsernameChangedEToS(
      LoginEmailChanged event) async* {
    yield state.copyWith(username: event.username);
  }

  Stream<LoginState> _mapPasswordChangedEToS(
      LoginPasswordChanged event) async* {
    yield state.copyWith(password: event.pwd);
  }


  Stream<LoginState> _mapLogInFormSubmissionEToS(
      LogInSubmissionEvent event) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    try{
      String username = state.username;
      String pwd = state.password;

      //Log in service call
      final res = await _userServices.customerLoginService(username,pwd);
      if(res){
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      }else{
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }catch(error){
      yield state.copyWith(status: FormzStatus.submissionFailure);
    }
  }
}
