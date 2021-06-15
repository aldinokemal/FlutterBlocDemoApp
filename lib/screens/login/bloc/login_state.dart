part of 'login_bloc.dart';

class LoginState {
  final String message;
  final FormzStatus status;
  final String email;
  final String password;

  LoginState({
    this.message = "",
    this.status = FormzStatus.pure,
    this.email = "",
    this.password = "",
  });

  LoginState copyWith({
    String? message,
    FormzStatus? status,
    String? email,
    String? password,
  }) {
    return LoginState(
      message: message ?? this.message,
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  List<Object> get props => [email, password, status, message];
}
