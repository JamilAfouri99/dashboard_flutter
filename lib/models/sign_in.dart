import 'package:equatable/equatable.dart';

class SignIn extends Equatable {
  static const emailProperty = 'email';
  static const passwordProperty = 'password';

  final String email;
  final String password;

  const SignIn({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        emailProperty: email,
        passwordProperty: password,
      };

  @override
  List<Object?> get props => [email, password];
}
