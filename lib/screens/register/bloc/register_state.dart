part of 'register_bloc.dart';

class RegisterState {
  RegisterState({this.fullname = "", this.email = "", this.password = ""});

  final String fullname;
  final String email;
  final String password;

  RegisterState copyWith({
    String? fullname,
    String? email,
    String? password,
  }) {
    return RegisterState(
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  List<Object> get props => [fullname, email, password];
}
