import 'package:flutter/widgets.dart' hide Action;
import 'package:injector/injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'di/leaders_screen_component.dart';


LeadersScreenWidgetModel createLeadersScreenWidgetModel(
    BuildContext context) {
  var component = Injector.of<LeadersScreenComponent>(context).component;

  return LeadersScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
  );
}

class LeadersScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;


  LeadersScreenWidgetModel(
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


}
