
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/main.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('Main App Initialization', () {
		testWidgets('shows LoginScreen on app start', (tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(LoginScreen), findsOneWidget);
		});

		testWidgets('shows HomeScreen when Authenticated state is emitted', (tester) async {
			final mockAuthCubit = MockAuthCubit();
			when(() => mockAuthCubit.state).thenReturn(Authenticated());
			
			await tester.pumpWidget(
				BlocProvider<AuthCubit>(
					create: (_) => mockAuthCubit,
					child: MyApp(),
				),
			);
			await tester.pumpAndSettle();

			expect(find.byType(HomeScreen), findsOneWidget);
		});

		testWidgets('shows LoginScreen when Unauthenticated state is emitted', (tester) async {
			final mockAuthCubit = MockAuthCubit();
			when(() => mockAuthCubit.state).thenReturn(Unauthenticated());

			await tester.pumpWidget(
				BlocProvider<AuthCubit>(
					create: (_) => mockAuthCubit,
					child: MyApp(),
				),
			);
			await tester.pumpAndSettle();

			expect(find.byType(LoginScreen), findsOneWidget);
		});
	});
}
