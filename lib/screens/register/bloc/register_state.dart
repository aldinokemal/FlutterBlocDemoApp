part of 'register_bloc.dart';

class RegisterState {
  RegisterState({
    this.fullname = "",
    this.email = "",
    this.password = "",
    this.message = "",
    this.status = FormzStatus.pure,
  });

  final String message;
  final FormzStatus status;
  final String fullname;
  final String email;
  final String password;

  RegisterState copyWith({
    String? fullname,
    String? email,
    String? password,
    FormzStatus? status,
    String? message,
  }) {
    return RegisterState(
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  List<Object> get props => [fullname, email, password, message, status];
}
