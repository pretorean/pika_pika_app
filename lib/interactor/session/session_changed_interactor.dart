import 'package:pika_pika_app/interactor/token/auth_token_storage.dart';
import 'package:rxdart/subjects.dart';

/// Интерактор сессии пользователя
class SessionChangedInteractor {
  final AuthTokenStorage _ts;

  final PublishSubject<SessionState> sessionSubject = PublishSubject();

  SessionChangedInteractor(this._ts);

  void onSessionChanged() {
    sessionSubject.add(SessionState.LOGGED_IN);
  }

  void forceLogout() {
    sessionSubject.add(SessionState.LOGGED_OUT);
    _ts.deleteAuthorization();
  }
}

enum SessionState { LOGGED_IN, LOGGED_OUT }
