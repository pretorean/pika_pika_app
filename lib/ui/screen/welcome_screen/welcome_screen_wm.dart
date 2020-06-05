import 'package:flutter/widgets.dart' hide Action;
import 'package:injector/injector.dart';
import 'package:pika_pika_app/interactor/session/session_changed_interactor.dart';
import 'package:pika_pika_app/ui/screen/welcome_screen/di/welcome_screen_component.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// Билдер для [WelcomeScreenWidgetModel].
WelcomeScreenWidgetModel createWelcomeWidgetModel(BuildContext context) {
  var component = Injector.of<WelcomeScreenComponent>(context).component;

  return WelcomeScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.sessionChangedInteractor,
  );
}

/// [WidgetModel] для экрана <Welcome>
class WelcomeScreenWidgetModel extends WidgetModel {
  final NavigatorState navigator;

  final SessionChangedInteractor sessionChangedInteractor;

  Action nextAction = Action();

  WelcomeScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this.sessionChangedInteractor,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();
    bind(nextAction, (_) {
      sessionChangedInteractor.forceLogout();
    });
  }
}
