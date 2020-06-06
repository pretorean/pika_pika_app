import 'package:flutter/widgets.dart' hide Action;
import 'package:injector/injector.dart';
import 'package:pika_pika_app/domain/post_message.dart';
import 'package:pika_pika_app/ui/screen/initiative_detail/di/initiative_detail_screen_component.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

InitiativeDetailWidgetModel createInitiativeDetailWidgetModel(
    BuildContext context) {
  var component = Injector.of<InitiativeDetailComponent>(context).component;

  return InitiativeDetailWidgetModel(
    component.wmDependencies,
    component.navigator,
  );
}

class InitiativeDetailWidgetModel extends WidgetModel {
  final NavigatorState _navigator;

  final dataState = EntityStreamedState<PostMessage>();

  InitiativeDetailWidgetModel(
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
