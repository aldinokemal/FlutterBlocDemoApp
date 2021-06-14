import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'forgetpassword_event.dart';

part 'forgetpassword_state.dart';

class ForgetpasswordBloc extends Bloc<ForgetpasswordEvent, ForgetpasswordState> {
  ForgetpasswordBloc() : super(ForgetpasswordState());

  @override
  Stream<ForgetpasswordState> mapEventToState(
    ForgetpasswordEvent event,
  ) async* {
    if (event is ForgetpasswordEmailChanged) {
      yield state.copyWith(email: event.email);
    }
  }
}
