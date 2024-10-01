
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.simple_app/models/user.dart';

void main() {
	group('User Model', () {
		test('User model can be instantiated', () {
			final user = User(email: 'test@example.com', name: 'Test User');
			expect(user.email, 'test@example.com');
			expect(user.name, 'Test User');
		});

		test('User model supports value comparisons', () {
			final user1 = User(email: 'test@example.com', name: 'Test User');
			final user2 = User(email: 'test@example.com', name: 'Test User');
			expect(user1, user2);
		});

		test('User model can be serialized to JSON', () {
			final user = User(email: 'test@example.com', name: 'Test User');
			expect(user.toJson(), {
				'email': 'test@example.com',
				'name': 'Test User'
			});
		});

		test('User model can be deserialized from JSON', () {
			final userJson = {
				'email': 'test@example.com',
				'name': 'Test User'
			};
			final user = User.fromJson(userJson);
			expect(user.email, 'test@example.com');
			expect(user.name, 'Test User');
		});
	});
}
