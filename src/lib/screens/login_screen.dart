
import 'package:flutter/material.dart';
import 'package:com.example.simple_app/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: Center(
				child: Padding(
					padding: const EdgeInsets.all(16.0),
					child: LoginForm(),
				),
			),
		);
	}
}
