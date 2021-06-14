import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterFullnameChanged) {
      yield state.copyWith(fullname: event.fullname);
    } else if (event is RegisterEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is RegisterPasswordChanged) {
      yield state.copyWith(password: event.password);
    }
  }
}
