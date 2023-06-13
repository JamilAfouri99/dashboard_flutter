import 'package:equatable/equatable.dart';

class SignUp extends Equatable {
  static const emailProperty = 'email';
  static const passwordProperty = 'password';
  static const firstNameProperty = 'firstName';
  static const lastNameProperty = 'lastName';

  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const SignUp({
    required this.email,
    required this.password,
    this.firstName = '',
    this.lastName = '',
  });

  Map<String, dynamic> toJson() => {
        emailProperty: email,
        passwordProperty: password,
        firstNameProperty: firstName,
        lastNameProperty: lastName,
      };

  @override
  List<Object?> get props => [email, password, firstName, lastName];
}
