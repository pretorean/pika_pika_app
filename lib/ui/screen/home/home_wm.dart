import 'package:flutter/widgets.dart' hide Action;
import 'package:injector/injector.dart';
import 'package:pika_pika_app/ui/screen/home/home_tab.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'di/home_screen_component.dart';

HomeScreenWidgetModel createHomeScreenWidgetModel(BuildContext context) {
  var component = Injector.of<HomeScreenComponent>(context).component;

  return HomeScreenWidgetModel(component.wmDependencies, component.navigator);
}

class HomeScreenWidgetModel extends WidgetModel {
  final NavigatorState _navigator;

  final homeTabState = StreamedState<HomeTab>(HomeTab.initiatives);

  final bottomNavigationAction = Action<HomeTab>();

  HomeScreenWidgetModel(
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

    bind(bottomNavigationAction, (tab) => _handleBottomNavigation(tab));

  }

  void _handleBottomNavigation(HomeTab tab) {
    homeTabState.accept(tab);
  }


}
