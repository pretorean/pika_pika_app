import 'package:flutter/widgets.dart' hide Action;
import 'package:injector/injector.dart';
import 'package:pika_pika_app/interactor/auth/auth_interactor.dart';
import 'package:pika_pika_app/ui/app/app.dart';
import 'package:pika_pika_app/ui/screen/register/di/register_screen_component.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

RegisterScreenWidgetModel createRegisterScreenWidgetModel(
    BuildContext context) {
  var component = Injector.of<RegisterScreenComponent>(context).component;

  return RegisterScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.authInteractor,
  );
}

class RegisterScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;

  final AuthInteractor _authInteractor;

  final Action switchToLoginAction = Action();
  final Action registerButtonAction = Action();

  RegisterScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._authInteractor,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();

    bind(switchToLoginAction, (_) => _openScreen(Router.loginScreen));
    bind(registerButtonAction, (_) => _handleRegisterButton());
  }

  void _openScreen(String routeName) {
    _navigator.pushReplacementNamed(routeName);
  }

  void _handleRegisterButton() async {
    doFutureHandleError(
        _authInteractor.register(
          firstName: 'Михаил',
          lastName: 'Иванов',
          email: 'ivamisha@mail.ru',
          password: '123',
        ), (bool isSuccess) {
      if (isSuccess) {
        _openScreen(Router.loginScreen);
      }
    });
  }
}
