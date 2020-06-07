import 'package:flutter/widgets.dart' hide Action;
import 'package:injector/injector.dart';
import 'package:pika_pika_app/interactor/auth/auth_interactor.dart';
import 'package:pika_pika_app/interactor/token/auth_token_storage.dart';
import 'package:pika_pika_app/ui/app/app.dart';
import 'package:pika_pika_app/ui/res/strings/strings.dart';
import 'package:pika_pika_app/ui/screen/login/di/login_screen_component.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

LoginScreenWidgetModel createLoginScreenWidgetModel(BuildContext context) {
  var component = Injector.of<LoginScreenComponent>(context).component;

  return LoginScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.authInteractor,
    component.authTokenStorage,
  );
}

class LoginScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;

  final AuthInteractor _authInteractor;
  final AuthTokenStorage _tokenStorage;

  final loadState = StreamedState<bool>(false);

  final Action switchToRegisterAction = Action();
  final Action loginButtonAction = Action();

  final TextFieldStreamedState phoneTextState = TextFieldStreamedState('');
  final TextFieldStreamedState passwordTextState = TextFieldStreamedState('');

  final TextEditingAction phoneChanges = TextEditingAction();
  final TextEditingAction passwordChanges = TextEditingAction();

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
    if (!validator.phone(phoneChanges.value ?? '')) {
      phoneTextState.error(IncorrectTextException(loginEnterPhone));
      return;
    } else {
      phoneTextState.content(phoneChanges.value);
    }

    if (passwordChanges.value?.isEmpty ?? true) {
      passwordTextState.error(IncorrectTextException(loginEnterPassword));
      return;
    } else {
      passwordTextState.content(passwordChanges.value);
    }

    loadState.accept(true);
    doFutureHandleError(
      _authInteractor.login(
        phone: phoneChanges.value,
        password: passwordChanges.value,
      ),
      (String token) {
        loadState.accept(false);
        _tokenStorage.saveAuthorization(token);
        if (_tokenStorage.hasToken) {
          _openScreen(Router.initiativesScreen);
        }
      },
      onError: (e) {
        loadState.accept(false);
      },
    );
  }
}
