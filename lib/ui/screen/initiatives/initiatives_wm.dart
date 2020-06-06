import 'package:flutter/widgets.dart' hide Action;
import 'package:injector/injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'di/initiatives_screen_component.dart';

InitiativesScreenWidgetModel createInitiativesScreenWidgetModel(BuildContext context) {
  var component = Injector.of<InitiativesScreenComponent>(context).component;

  return InitiativesScreenWidgetModel(component.wmDependencies, component.navigator);
}

class InitiativesScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;


  InitiativesScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();

  }
  void _openScreen(String routeName) {
    _navigator.pushReplacementNamed(routeName);
  }
}
