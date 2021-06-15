part of 'login_bloc.dart';

class LoginState {
  final bool loading;
  final String status;
  final String email;
  final String password;

  LoginState({
    this.loading = false,
    this.status = "",
    this.email = "",
    this.password = "",
  });

  LoginState copyWith({
    String? status,
    String? email,
    String? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [email, password];
}
