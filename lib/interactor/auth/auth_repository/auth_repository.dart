import 'package:flutter/widgets.dart';
import 'package:network/network.dart';
import 'package:pika_pika_app/interactor/auth/auth_repository/data/login_request.dart';
import 'package:pika_pika_app/interactor/auth/auth_repository/data/register_request.dart';
import 'package:pika_pika_app/interactor/auth/auth_repository/data/token_response.dart';
import 'package:pika_pika_app/interactor/common/urls.dart';

/// Репозиторий
class AuthRepository {
  final DioHttp _http;

  AuthRepository(this._http);

  /// регистрации
  Future<bool> register({
    @required String firstName,
    @required String lastName,
    @required String phone,
    @required String password,
  }) async {
    var body = RegisterRequest(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      password: password,
    ).json;
    var response = await _http.post(AuthUrl.registerUrl, body: body);
    return response.statusCode == 204;
  }

  /// авторизация
  Future<String> login({
    @required String phone,
    @required String password,
  }) async {
    var body = LoginRequest(
      phone: phone,
      password: password,
    ).json;
    var response = await _http.post(AuthUrl.loginUrl, body: body);
    return TokenResponse.fromJson(response.body).transform();
  }
}
