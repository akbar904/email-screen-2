
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/screens/login_screen.dart';
import 'package:com.example.simple_app/widgets/login_form.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';
import 'package:com.example.simple_app/cubits/auth_state.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('LoginScreen displays LoginForm', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: LoginScreen(),
					),
				),
			);

			expect(find.byType(LoginForm), findsOneWidget);
		});
	});

	group('LoginForm Widget Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		testWidgets('LoginForm displays email and password fields', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (_) => mockAuthCubit,
							child: LoginForm(),
						),
					),
				),
			);

			expect(find.byKey(Key('emailField')), findsOneWidget);
			expect(find.byKey(Key('passwordField')), findsOneWidget);
			expect(find.byType(ElevatedButton), findsOneWidget);
		});

		testWidgets('LoginForm triggers login on button press', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (_) => mockAuthCubit,
							child: LoginForm(),
						),
					),
				),
			);

			final emailField = find.byKey(Key('emailField'));
			final passwordField = find.byKey(Key('passwordField'));
			final loginButton = find.byType(ElevatedButton);

			await tester.enterText(emailField, 'test@example.com');
			await tester.enterText(passwordField, 'password');
			await tester.tap(loginButton);

			verify(() => mockAuthCubit.login('test@example.com', 'password')).called(1);
		});
	});
}
