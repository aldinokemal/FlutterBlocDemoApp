part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}

class LoginEmailChanged extends LoginEvent {
  final String email;

  LoginEmailChanged({required this.email});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class LoginWithGoogle extends LoginEvent {
  const LoginWithGoogle();
}
