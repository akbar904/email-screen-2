
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/cubits/auth_state.dart';

void main() {
	group('AuthState Tests', () {
		test('AuthInitial state should be an instance of AuthState', () {
			expect(AuthInitial(), isA<AuthState>());
		});

		test('Authenticated state should be an instance of AuthState', () {
			expect(Authenticated(), isA<AuthState>());
		});

		test('Unauthenticated state should be an instance of AuthState', () {
			expect(Unauthenticated(), isA<AuthState>());
		});
	});
}
