
import 'dart:convert';

class User {
	final String email;
	final String name;

	User({required this.email, required this.name});

	Map<String, dynamic> toJson() {
		return {
			'email': email,
			'name': name,
		};
	}

	factory User.fromJson(Map<String, dynamic> json) {
		return User(
			email: json['email'],
			name: json['name'],
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(this, other)) return true;

		return other is User &&
			other.email == email &&
			other.name == name;
	}

	@override
	int get hashCode => email.hashCode ^ name.hashCode;
}
