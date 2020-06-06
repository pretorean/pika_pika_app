import 'package:flutter/widgets.dart' hide Action;
import 'package:injector/injector.dart';
import 'package:pika_pika_app/domain/post_message.dart';
import 'package:pika_pika_app/interactor/initiative/initiative_interactor.dart';
import 'package:pika_pika_app/ui/screen/initiative_detail/di/initiative_detail_screen_component.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

InitiativeDetailWidgetModel createInitiativeDetailWidgetModel(
    BuildContext context) {
  var component = Injector.of<InitiativeDetailComponent>(context).component;

  return InitiativeDetailWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.initiativeInteractor,
    component.postId,
  );
}

class InitiativeDetailWidgetModel extends WidgetModel {
  final NavigatorState _navigator;

  final InitiativeInteractor _initiativeInteractor;

  final String _postId;

  final dataState = EntityStreamedState<PostMessage>();

  InitiativeDetailWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._initiativeInteractor,
    this._postId,
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

  void _openScreen(String routeName) {
    _navigator.pushReplacementNamed(routeName);
  }

  void _loadData() {
    dataState.loading();
    doFutureHandleError(
      _initiativeInteractor.getPostById(_postId),
      (PostMessage post) {
        dataState.content(post);
      },
      onError: (e) {
        dataState.error(e);
      },
    );
  }
}
