import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/ui/common/widgets/bottom_navigation.dart';
import 'package:pika_pika_app/ui/screen/home/home_tab.dart';
import 'package:pika_pika_app/ui/screen/initiatives/initiatives_screen.dart';
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
    return StreamedStateBuilder<HomeTab>(
      streamedState: wm.homeTabState,
      builder: (context, homeTab) {
        return Stack(
          children: <Widget>[
            _getBodyPage(homeTab),
            BottomNavigation(homeTab)
          ],
        );
      },
    );
  }

  Widget _getBodyPage(HomeTab homeTab) {
    if (homeTab == HomeTab.initiatives) {
      return InitiativesScreen();
    } else {
      return Container();
    }
  }
}

