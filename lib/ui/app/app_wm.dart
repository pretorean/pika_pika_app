import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';
import 'package:pika_pika_app/interactor/session/session_changed_interactor.dart';
import 'package:pika_pika_app/ui/app/app.dart';

import 'di/app.dart';

/// Билдер для [AppWidgetModel].
AppWidgetModel createAppWidgetModel(BuildContext context) {
  var component = Injector.of<AppComponent>(context).component;

  return AppWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.scInteractor,
  );
}

/// [WidgetModel] для виджета приложения
class AppWidgetModel extends WidgetModel {
  final GlobalKey<NavigatorState> _navigator;
  final SessionChangedInteractor _sessionInteractor;

  AppWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._sessionInteractor,
  ) : super(dependencies);

  @override
  void onBind() {
    super.onBind();
    subscribe<SessionState>(
      _sessionInteractor.sessionSubject,
      (SessionState state) {
        switch (state) {
          case SessionState.LOGGED_IN:
            break;
          case SessionState.LOGGED_OUT:
            _navigator.currentState.pushNamedAndRemoveUntil(
              Router.loginScreen,
              (route) => false,
            );
            break;
        }
      },
    );
  }
}
