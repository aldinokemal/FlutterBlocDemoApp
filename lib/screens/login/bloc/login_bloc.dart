import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:my_app/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/screens/login/models/email.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      print(state.email.value);
      print(state.password.value);
      print(state.status.isValid);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", 'aspdokapsdkpaksd');
      yield _processLoginChangedToState(event, state);
    }
  }

  LoginState _mapEmailChangedToState(
    LoginEmailChanged event,
    LoginState state,
  ) {
    final data = Email.dirty(event.email);
    return state.copyWith(
      email: data,
      status: Formz.validate([state.password, data]),
    );
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    final data = Password.dirty(event.password);
    return state.copyWith(
      password: data,
      status: Formz.validate([data, state.email]),
    );
  }

  LoginState _processLoginChangedToState(
    LoginSubmitted event,
    LoginState state,
  ) {
    return state.copyWith(
      password: Password.pure(),
      email: Email.pure(),
    );
  }
}
