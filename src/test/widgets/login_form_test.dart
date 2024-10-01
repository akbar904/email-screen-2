
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/widgets/login_form.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginForm Widget Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('should display email and password fields and login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>.value(
							value: authCubit,
							child: LoginForm(),
						),
					),
				),
			);

			expect(find.byType(TextFormField), findsNWidgets(2)); // Email and Password fields
			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
			expect(find.byType(ElevatedButton), findsOneWidget); // Login button
		});

		testWidgets('should call login method when login button is pressed', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>.value(
							value: authCubit,
							child: LoginForm(),
						),
					),
				),
			);

			final emailField = find.byKey(const Key('emailField'));
			final passwordField = find.byKey(const Key('passwordField'));
			final loginButton = find.byType(ElevatedButton);

			await tester.enterText(emailField, 'test@example.com');
			await tester.enterText(passwordField, 'password123');
			await tester.tap(loginButton);

			verify(() => authCubit.login('test@example.com', 'password123')).called(1);
		});
	});

	group('AuthCubit Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = AuthCubit();
		});

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, Authenticated] when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password123'),
			expect: () => [AuthLoading(), Authenticated()],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, Unauthenticated] when login fails',
			build: () => authCubit,
			act: (cubit) => cubit.login('wrong@example.com', 'wrongpassword'),
			expect: () => [AuthLoading(), Unauthenticated()],
		);
	});
}
