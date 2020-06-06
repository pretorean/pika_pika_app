import 'package:flutter/widgets.dart' hide Action;
import 'package:injector/injector.dart';
import 'package:pika_pika_app/domain/post_message.dart';
import 'package:pika_pika_app/interactor/initiative/initiative_interactor.dart';
import 'package:pika_pika_app/ui/app/app.dart';
import 'package:pika_pika_app/ui/screen/initiatives/initiatives_filter.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'di/initiatives_screen_component.dart';

InitiativesScreenWidgetModel createInitiativesScreenWidgetModel(
    BuildContext context) {
  var component = Injector.of<InitiativesScreenComponent>(context).component;

  return InitiativesScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.initiativeInteractor,
  );
}

class InitiativesScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;

  final InitiativeInteractor initiativeInteractor;

  final filterAction = Action<InitiativesFilter>();
  final filterState =
      StreamedState<InitiativesFilter>(InitiativesFilter.active);

  final openDetailAction = Action<String>();

  final initiativesState = EntityStreamedState<List<PostMessage>>();

  InitiativesScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this.initiativeInteractor,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();

    _loadInitiatives();
  }

  @override
  void onBind() {
    super.onBind();

    bind(filterAction, (filter) {
      filterState.accept(filter);
    });

    bind(openDetailAction, (String postId) => _openDetailScreen(postId));
  }

  void _loadInitiatives() {
    initiativesState.loading();

    doFutureHandleError(initiativeInteractor.getPosts(), (posts) {
      initiativesState.content(posts);
    }, onError: (e) {
      initiativesState.error(e);
    });
  }

  void _openDetailScreen(String postId) {
    _navigator.pushNamed(
      Router.initiativesDetailScreen,
      arguments: postId,
    );
  }
}
