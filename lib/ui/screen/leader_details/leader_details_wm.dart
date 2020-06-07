import 'package:flutter/widgets.dart' hide Action;
import 'package:injector/injector.dart';
import 'package:pika_pika_app/domain/leader.dart';
import 'package:pika_pika_app/interactor/leader/leader_interactor.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'di/leader_details_screen_component.dart';

LeaderDetailsScreenWidgetModel createLeaderDetailsScreenWidgetModel(
    BuildContext context) {
  var component = Injector.of<LeaderDetailsScreenComponent>(context).component;

  return LeaderDetailsScreenWidgetModel(component.wmDependencies,
      component.navigator, component.leaderInteractor, component.leaderId);
}

class LeaderDetailsScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;

  final LeaderInteractor _leaderInteractor;

  final String _leaderId;

  final dataState = EntityStreamedState<Leader>();

  LeaderDetailsScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._leaderInteractor,
    this._leaderId,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();

    _loadData();
  }

  @override
  void onBind() {
    super.onBind();
  }

  void _loadData() {
    dataState.loading();
    doFutureHandleError(
      _leaderInteractor.getLeaderById(_leaderId), (Leader leader) {
        dataState.content(leader);
      },
      onError: (e) {
        dataState.error(e);
      },
    );
  }
}
