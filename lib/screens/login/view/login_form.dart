import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/screens/login/bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Authentication Failure')),
              );
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _Logo(),
                _InputEmail(),
                _InputPassword(),
                TextButton(
                  onPressed: () {
                    //TODO FORGOT PASSWORD SCREEN GOES HERE
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Text('Create Account')
              ],
            ),
          ),
        ));
  }
}

// Form Input Email
class _InputEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            validator: (value) {
              bool emailValid =
                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
              if (value.isEmpty) {
                return 'Please enter some text';
              } else if (!emailValid) {
                return 'Please enter valid email';
              }
              return null;
            },
            onChanged: (data) => context.read<LoginBloc>().add(LoginEmailChanged(email: data)),
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Email', hintText: 'Enter valid email id as abc@gmail.com'),
          ),
        );
      },
    );
  }
}

// Form Input Password
class _InputPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            obscureText: true,
            onChanged: (data) => context.read<LoginBloc>().add(LoginPasswordChanged(password: data)),
            decoration:
                InputDecoration(border: OutlineInputBorder(), labelText: "Password", hintText: 'Enter secure password'),
          ),
        );
      },
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Center(
        child: Container(width: 200, height: 150, child: Image.asset('assets/images/app-logo.png')),
      ),
    );
  }
}
