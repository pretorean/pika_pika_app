import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/interactor/auth/auth_interactor.dart';
import 'package:pika_pika_app/interactor/token/auth_token_storage.dart';
import 'package:pika_pika_app/ui/app/di/app.dart';
import 'package:pika_pika_app/ui/base/di/widget_component.dart';

class LoginScreenComponent extends WidgetComponent {
  AuthInteractor authInteractor;
  AuthTokenStorage authTokenStorage;

  LoginScreenComponent(BuildContext context) : super(context) {
    var app = Injector.of<AppComponent>(context).component;

    authInteractor = app.authInteractor;
    authTokenStorage = app.authTokenStorage;
  }
}
