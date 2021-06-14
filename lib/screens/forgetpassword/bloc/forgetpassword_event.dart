part of 'forgetpassword_bloc.dart';

abstract class ForgetpasswordEvent extends Equatable {
  const ForgetpasswordEvent();
}

class ForgetpasswordEmailChanged extends ForgetpasswordEvent {
  final String email;

  ForgetpasswordEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}
