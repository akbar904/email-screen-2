
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/screens/home_screen.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';
import 'package:com.example.simple_app/cubits/auth_state.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('should display the HomeScreen with a logout button', (WidgetTester tester) async {
			// Arrange
			final mockAuthCubit = MockAuthCubit();

			when(() => mockAuthCubit.state).thenReturn(Authenticated());

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: HomeScreen(),
					),
				),
			);

			// Assert
			expect(find.text('Home Screen'), findsOneWidget);
			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('should call logout method when logout button is tapped', (WidgetTester tester) async {
			// Arrange
			final mockAuthCubit = MockAuthCubit();

			when(() => mockAuthCubit.state).thenReturn(Authenticated());
			when(() => mockAuthCubit.logout()).thenReturn(null);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: HomeScreen(),
					),
				),
			);

			// Act
			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			// Assert
			verify(() => mockAuthCubit.logout()).called(1);
		});
	});
}
