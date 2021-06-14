part of 'forgetpassword_bloc.dart';

class ForgetpasswordState extends Equatable {
  final String email;

  const ForgetpasswordState({
    this.email = "",
  });

  ForgetpasswordState copyWith({
    String? email,
  }) {
    return ForgetpasswordState(
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [email];
}
