import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:my_app/repos/models/register.dart';
import 'package:my_app/repos/repository/register_repository.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    yield state.copyWith(status: FormzStatus.pure);
    if (event is RegisterFullnameChanged) {
      yield state.copyWith(fullname: event.fullname);
    } else if (event is RegisterEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is RegisterPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is RegisterSubmitted) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        ApiRegister response;
        response = await RegisterRepository().postRegister(state.email, state.password, state.fullname);
        yield state.copyWith(status: FormzStatus.submissionSuccess, message: response.message);
      } catch (err) {
        print(err.toString());
        yield state.copyWith(status: FormzStatus.submissionFailure, message: err.toString());
      }
    }
  }
}
