import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/ui/app/di/app.dart';
import 'package:pika_pika_app/ui/base/di/widget_component.dart';

class LeadersScreenComponent extends WidgetComponent {

  LeadersScreenComponent(BuildContext context) : super(context) {
    var app = Injector.of<AppComponent>(context).component;
  }
}
