import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/interactor/token/auth_token_storage.dart';
import 'package:pika_pika_app/ui/app/di/app.dart';
import 'package:pika_pika_app/ui/base/di/widget_component.dart';

/// [Component] для экрана <SplashScreen>
class SplashScreenComponent extends WidgetComponent {
  AuthTokenStorage authTokenStorage;

  SplashScreenComponent(BuildContext context) : super(context) {
    var app = Injector.of<AppComponent>(context).component;

    authTokenStorage = app.authTokenStorage;
  }
}
