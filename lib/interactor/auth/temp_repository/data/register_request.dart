import 'package:flutter/foundation.dart';

/// Объект запроса регистрации нового пользователя
class RegisterRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  RegisterRequest({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
  });

  Map<String, dynamic> get json => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      };
}
