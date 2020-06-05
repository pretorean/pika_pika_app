import 'package:network/network.dart';
import 'package:pika_pika_app/interactor/token/auth_token_storage.dart';
import 'package:pika_pika_app/util/const.dart';

/// Реализация билдера заголовков http запросов
class DefaultHeaderBuilder extends HeadersBuilder {
  String t = emptyString;

  final AuthTokenStorage _ts;

  DefaultHeaderBuilder(this._ts);

  @override
  Future<Map<String, String>> buildDynamicHeader(String url) async {
    var token = await _ts.getAccessToken();
    return url != emptyString //todo доработать
        ? {
            'X-Auth-Token': token,
          }
        : {};
  }
}
