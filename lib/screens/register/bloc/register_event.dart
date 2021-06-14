part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterFullnameChanged extends RegisterEvent {
  final String fullname;

  RegisterFullnameChanged({required this.fullname});
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  RegisterEmailChanged({required this.email});
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  RegisterPasswordChanged({required this.password});
}
