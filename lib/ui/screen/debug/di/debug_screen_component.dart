import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/ui/app/di/app.dart';
import 'package:pika_pika_app/ui/base/di/widget_component.dart';

/// [Component] для экрана <Debug>
class DebugScreenComponent extends WidgetComponent {
  VoidCallback rebuildApplication;

  DebugScreenComponent(BuildContext context) : super(context) {
    var app = Injector.of<AppComponent>(context).component;

    rebuildApplication = app.rebuildDependencies;
  }
}
