import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/interactor/profile/profile_interactor.dart';
import 'package:pika_pika_app/ui/app/di/app.dart';
import 'package:pika_pika_app/ui/base/di/widget_component.dart';

class ProfileScreenComponent extends WidgetComponent {

  ProfileInteractor profileInteractor;

  ProfileScreenComponent(BuildContext context) : super(context) {
    var app = Injector.of<AppComponent>(context).component;

    profileInteractor = app.profileInteractor;
  }
}
