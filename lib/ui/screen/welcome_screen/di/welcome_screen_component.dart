import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/interactor/session/session_changed_interactor.dart';
import 'package:pika_pika_app/ui/app/di/app.dart';
import 'package:pika_pika_app/ui/base/di/widget_component.dart';

/// [Component] для экрана <Welcome>
class WelcomeScreenComponent extends WidgetComponent {
  SessionChangedInteractor sessionChangedInteractor;

  WelcomeScreenComponent(BuildContext context) : super(context) {
    var app = Injector.of<AppComponent>(context).component;

    sessionChangedInteractor = app.scInteractor;
  }
}
