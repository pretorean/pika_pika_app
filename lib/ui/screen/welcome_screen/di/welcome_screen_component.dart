import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/interactor/counter/counter_interactor.dart';
import 'package:pika_pika_app/ui/app/di/app.dart';
import 'package:pika_pika_app/ui/base/di/widget_component.dart';

/// [Component] для экрана <Welcome>
class WelcomeScreenComponent extends WidgetComponent {
  CounterInteractor counterInteractor;

  WelcomeScreenComponent(BuildContext context) : super(context) {
    var app = Injector.of<AppComponent>(context).component;

    counterInteractor = app.counterInteractor;
  }
}
