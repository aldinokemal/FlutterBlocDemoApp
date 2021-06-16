import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

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
      // yield state.copyWith(status: FormzStatus.submissionInProgress);
      print("sedang register");
      print(state.fullname);
      print(state.email);
      print(state.password);
    }
  }
}
