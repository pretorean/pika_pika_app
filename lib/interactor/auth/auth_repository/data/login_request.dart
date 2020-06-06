import 'package:flutter/foundation.dart';

/// Объект запроса
class LoginRequest {
  final String phone;
  final String password;

  LoginRequest({
    @required this.phone,
    @required this.password,
  });

  Map<String, dynamic> get json => {
        'phone': phone,
        'password': password,
      };
}
