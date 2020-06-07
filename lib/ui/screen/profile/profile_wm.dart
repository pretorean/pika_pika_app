import 'package:flutter/widgets.dart' hide Action;
import 'package:injector/injector.dart';
import 'package:pika_pika_app/domain/voice_way_step.dart';
import 'package:pika_pika_app/interactor/profile/profile_interactor.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'di/profile_screen_component.dart';

ProfileScreenWidgetModel createProfileScreenWidgetModel(BuildContext context) {
  var component = Injector.of<ProfileScreenComponent>(context).component;

  return ProfileScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.profileInteractor
  );
}

class ProfileScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;

  final ProfileInteractor _profileInteractor;

  final voiceWayState = EntityStreamedState<List<VoiceWayStep>>();

  ProfileScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._profileInteractor,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();

    _loadVoiceWay();
  }

  @override
  void onBind() {
    super.onBind();
  }

  void _loadVoiceWay() {
    voiceWayState.loading();

    doFutureHandleError(_profileInteractor.getVoiceWay(), (leaders) {
      voiceWayState.content(leaders);
    }, onError: (e) {
      voiceWayState.error(e);
    });
  }

}
