import 'package:flutter/widgets.dart' hide Action;
import 'package:injector/injector.dart';
import 'package:pika_pika_app/domain/leader.dart';
import 'package:pika_pika_app/interactor/leader/leader_interactor.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'di/profile_screen_component.dart';

ProfileScreenWidgetModel createProfileScreenWidgetModel(BuildContext context) {
  var component = Injector.of<ProfileScreenComponent>(context).component;

  return ProfileScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.leaderInteractor
  );
}

class ProfileScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;

  final LeaderInteractor _leaderInteractor;

  final leadersState = EntityStreamedState<List<Leader>>();


  ProfileScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._leaderInteractor,
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
