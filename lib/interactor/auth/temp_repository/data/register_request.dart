import 'package:flutter/foundation.dart';

/// Объект запроса регистрации нового пользователя
class RegisterRequest {
  final String firstName;
  final String lastName;
  final String phone;
  final String password;

  RegisterRequest({
    @required this.firstName,
    @required this.lastName,
    @required this.phone,
    @required this.password,
  });

  Map<String, dynamic> get json => {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'password': password,
      };
}
