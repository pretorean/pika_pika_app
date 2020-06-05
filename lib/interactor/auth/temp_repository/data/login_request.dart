import 'package:flutter/foundation.dart';

/// Объект запроса
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    @required this.email,
    @required this.password,
  });

  Map<String, dynamic> get json => {
        'email': email,
        'password': password,
      };
}
