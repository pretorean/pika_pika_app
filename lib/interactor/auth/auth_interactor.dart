import 'package:flutter/widgets.dart';
import 'package:pika_pika_app/interactor/auth/temp_repository/auth_repository.dart';

/// Интерактор авторизации
class AuthInteractor {
  final AuthRepository repository;

  AuthInteractor(this.repository);

  /// регистрация
  Future<bool> register({
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String password,
  }) async =>
      repository.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );

  /// авторизация
  Future<String> login({
    @required String email,
    @required String password,
  }) async =>
      repository.login(
        email: email,
        password: password,
      );
}
