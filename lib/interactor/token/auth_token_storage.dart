import 'package:pika_pika_app/util/const.dart';
import 'package:pika_pika_app/util/sp_helper.dart';

/// Хранилище токена сессии
class AuthTokenStorage {
  static const _accessTokenKey = 'accessToken';

  final PreferencesHelper _preferencesHelper;

  /// токен авторизации
  String _token;

  /// проверка есть ли значение токена
  bool get hasToken => _token != null;

  AuthTokenStorage(this._preferencesHelper);

  /// попытка восстановления авторизации после рестарта приложения
  Future<bool> tryRestoreAuthorization() async {
    var accessToken = await _preferencesHelper.get(
      _accessTokenKey,
      emptyString,
    );

    var result = accessToken.isNotEmpty;
    if (result) {
      _token = accessToken;
    }
    return result;
  }

  /// сохранение авторизации в хранилище
  Future<void> saveAuthorization(String token) async {
    _token = token;
    await _preferencesHelper.set(_accessTokenKey, token);
    return;
  }

  /// удаление авторизации из хранилища
  Future<void> deleteAuthorization() async {
    _token = null;
    await _preferencesHelper.remove(_accessTokenKey);
    return;
  }

  /// получение токена авторизации
  Future<String> getAccessToken() async {
    if (!hasToken) return emptyString;
    return _token;
  }
}
