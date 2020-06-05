import 'package:flutter/widgets.dart' hide Action;
import 'package:injector/injector.dart';
import 'package:pika_pika_app/interactor/auth/auth_interactor.dart';
import 'package:pika_pika_app/interactor/token/auth_token_storage.dart';
import 'package:pika_pika_app/ui/app/app.dart';
import 'package:pika_pika_app/ui/screen/login/di/login_screen_component.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

LoginScreenWidgetModel createLoginScreenWidgetModel(BuildContext context) {
  var component = Injector.of<LoginScreenComponent>(context).component;

  return LoginScreenWidgetModel(component.wmDependencies, component.navigator,
      component.authInteractor, component.authTokenStorage);
}

class LoginScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;

  final AuthInteractor _authInteractor;
  final AuthTokenStorage _tokenStorage;

  final Action switchToRegisterAction = Action();
  final Action loginButtonAction = Action();

  LoginScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._authInteractor,
    this._tokenStorage,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();

    bind(switchToRegisterAction, (_) => _openScreen(Router.registerScreen));
    bind(loginButtonAction, (_) => _handleLoginButton());
  }

  void _openScreen(String routeName) {
    _navigator.pushReplacementNamed(routeName);
  }

  void _handleLoginButton() {
    doFutureHandleError(
        _authInteractor.login(
          email: 'ivamisha@mail.ru',
          password: '123',
        ), (String token) {
      _tokenStorage.saveAuthorization(token);
      if (_tokenStorage.hasToken) {
        _openScreen(Router.root);
      }
    });
  }
}
