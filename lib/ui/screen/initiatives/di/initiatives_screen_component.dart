import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/interactor/initiative/initiative_interactor.dart';
import 'package:pika_pika_app/ui/app/di/app.dart';
import 'package:pika_pika_app/ui/base/di/widget_component.dart';

class InitiativesScreenComponent extends WidgetComponent {

  InitiativeInteractor initiativeInteractor;

  InitiativesScreenComponent(BuildContext context) : super(context) {
    var app = Injector.of<AppComponent>(context).component;

    initiativeInteractor = app.initiativeInteractor;
  }
}
