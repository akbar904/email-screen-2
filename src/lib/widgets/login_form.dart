
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';

class LoginForm extends StatefulWidget {
	@override
	_LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
	final _emailController = TextEditingController();
	final _passwordController = TextEditingController();
	final _formKey = GlobalKey<FormState>();

	@override
	void dispose() {
		_emailController.dispose();
		_passwordController.dispose();
		super.dispose();
	}

	void _onLoginButtonPressed() {
		if (_formKey.currentState!.validate()) {
			final email = _emailController.text;
			final password = _passwordController.text;
			context.read<AuthCubit>().login(email, password);
		}
	}

	@override
	Widget build(BuildContext context) {
		return Form(
			key: _formKey,
			child: Column(
				children: [
					TextFormField(
						key: const Key('emailField'),
						controller: _emailController,
						decoration: const InputDecoration(labelText: 'Email'),
						validator: (value) {
							if (value == null || value.isEmpty) {
								return 'Please enter your email';
							}
							return null;
						},
					),
					TextFormField(
						key: const Key('passwordField'),
						controller: _passwordController,
						decoration: const InputDecoration(labelText: 'Password'),
						obscureText: true,
						validator: (value) {
							if (value == null || value.isEmpty) {
								return 'Please enter your password';
							}
							return null;
						},
					),
					ElevatedButton(
						onPressed: _onLoginButtonPressed,
						child: const Text('Login'),
					),
				],
			),
		);
	}
}
