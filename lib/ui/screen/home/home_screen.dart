import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:injector/injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'di/home_screen_component.dart';
import 'home_wm.dart';

class HomeScreen extends MwwmWidget<HomeScreenComponent> {
  HomeScreen([
    WidgetModelBuilder widgetModelBuilder = createHomeScreenWidgetModel,
  ]) : super(
          dependenciesBuilder: (context) => HomeScreenComponent(context),
          widgetStateBuilder: () => _HomeScreenState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _HomeScreenState extends WidgetState<HomeScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<HomeScreenComponent>(context).component.scaffoldKey,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {

  }

}
