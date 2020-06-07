import 'package:flutter/widgets.dart' hide Action;
import 'package:injector/injector.dart';
import 'package:pika_pika_app/domain/leader.dart';
import 'package:pika_pika_app/interactor/leader/leader_interactor.dart';
import 'package:pika_pika_app/ui/app/app.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'di/leaders_screen_component.dart';

LeadersScreenWidgetModel createLeadersScreenWidgetModel(BuildContext context) {
  var component = Injector.of<LeadersScreenComponent>(context).component;

  return LeadersScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.leaderInteractor
  );
}

class LeadersScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;

  final LeaderInteractor _leaderInteractor;

  final leadersState = EntityStreamedState<List<Leader>>();

  final openDetailAction = Action<String>();

  LeadersScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._leaderInteractor,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();

    _loadLeaders();
  }

  @override
  void onBind() {
    super.onBind();

    bind(openDetailAction, (String leaderId) => _openDetailScreen(leaderId));
  }

  void _openDetailScreen(String leaderId) {
    _navigator.pushNamed(
      Router.leaderDetailsScreen,
      arguments: leaderId,
    );
  }

  void _loadLeaders() {
    leadersState.loading();

    doFutureHandleError(_leaderInteractor.getLeaders(), (leaders) {
      leadersState.content(leaders);
    }, onError: (e) {
      leadersState.error(e);
    });
  }
}
