import 'package:pika_pika_app/interactor/base/transformable.dart';

/// тело ответа с токеном
class TokenResponse implements Transformable<String> {
  final String message;
  final String jwt;

  TokenResponse({
    this.message,
    this.jwt,
  });

  TokenResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        jwt = json['jwt'];

  @override
  String transform() => jwt;
}
