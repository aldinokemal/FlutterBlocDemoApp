import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:my_app/repos/models/login.dart';
import 'package:my_app/repos/repository/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield state.copyWith(status: FormzStatus.pure);
    if (event is LoginEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      print("process Login");
      print(state.email + "|" + state.password);
      try {
        ApiLogin response;
        response = await LoginRepository().postLogin(state.email, state.password);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", response.results!.accessToken.toString());
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } catch (err) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }

  LoginState _mapEmailChangedToState(
    LoginEmailChanged event,
    LoginState state,
  ) {
    return state.copyWith(email: event.email);
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    return state.copyWith(password: event.password);
  }
}
