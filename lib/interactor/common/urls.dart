import 'package:pika_pika_app/config/config.dart';
import 'package:pika_pika_app/config/env/env.dart';

///URL запросов сервера
abstract class Url {
  /// хост для локальной разработки
  static String get localDomain => 'localhost';

  /// хост удаленного сервера
  static String get remoteDomain => 'hackathon.bizness-pro.ru';

  /// хост продуктового сервера
  static String get prodDomain => 'hackathon.bizness-pro.ru';

  static String get devUrl => 'https://$localDomain';

  static String get testUrl => 'https://$remoteDomain';

  static String get prodUrl => 'https://$prodDomain';

  /// ----

  static String get baseUrl => Environment<Config>.instance().config.url;

  static String get prodProxyUrl => '';

  static String get qaProxyUrl => '';

  static String get devProxyUrl => '';

  /// Является ли указанный [url] адресом продашкн-сервера.
  static bool isProdUrl(String url) => url == prodUrl;
}

///URL запросов авторизации
abstract class AuthUrl {
  static String get baseUrl => '/api';

  static String get registerUrl => '$baseUrl/register.php';

  static String get loginUrl => '$baseUrl/login.php';
}

abstract class InitiativeUrl {
  static String get baseUrl => '/api';

  static String get postUrl => '$baseUrl/getPost.php';

  static String get postsListUrl => '$baseUrl/getListPosts.php';

  static String get likePostUrl => '$baseUrl/addLike.php';
}
