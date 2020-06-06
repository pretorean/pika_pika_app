import 'package:flutter/widgets.dart' hide Action;
import 'package:injector/injector.dart';
import 'package:pika_pika_app/interactor/auth/auth_interactor.dart';
import 'package:pika_pika_app/ui/app/app.dart';
import 'package:pika_pika_app/ui/res/strings/strings.dart';
import 'package:pika_pika_app/ui/screen/register/di/register_screen_component.dart';
import 'package:regexed_validator/regexed_validator.dart';
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

  final loadState = StreamedState<bool>(false);

  final TextFieldStreamedState phoneTextState = TextFieldStreamedState('');
  final TextFieldStreamedState passwordTextState = TextFieldStreamedState('');
  final TextFieldStreamedState firstNameTextState = TextFieldStreamedState('');
  final TextFieldStreamedState lastNameTextState = TextFieldStreamedState('');

  final TextEditingAction phoneChanges = TextEditingAction();
  final TextEditingAction passwordChanges = TextEditingAction();
  final TextEditingAction firstNameChanges = TextEditingAction();
  final TextEditingAction lastNameChanges = TextEditingAction();

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

  void _handleRegisterButton() {
    if (firstNameChanges.value?.isEmpty ?? true) {
      firstNameTextState.error(IncorrectTextException(loginEnterFirstName));
      return;
    } else {
      firstNameTextState.content(firstNameChanges.value);
    }
    if (lastNameChanges.value?.isEmpty ?? true) {
      lastNameTextState.error(IncorrectTextException(loginEnterLastName));
      return;
    } else {
      lastNameTextState.content(lastNameChanges.value);
    }

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
      _authInteractor.register(
        firstName: firstNameChanges.value,
        lastName: lastNameChanges.value,
        phone: phoneChanges.value,
        password: passwordChanges.value,
      ),
      (bool isSuccess) {
        loadState.accept(false);
        if (isSuccess) {
          _openScreen(Router.loginScreen);
        }
      },
      onError: (e) {
        loadState.accept(false);
      },
    );
  }
}
