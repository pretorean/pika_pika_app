import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/ui/res/colors.dart';
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
            BottomNavigation(homeTab, (tab) {
              wm.bottomNavigationAction.accept(tab);
            })
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

class BottomNavigation extends StatelessWidget {

  final HomeTab currentTab;
  final Function(HomeTab tab) onTap;

  BottomNavigation(this.currentTab, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 102,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            for (var tab in HomeTab.values) createButton(tab)
          ],
        ),
      ),
    );
  }

  ButtonNavigationButton createButton(HomeTab tab) {
    return ButtonNavigationButton(currentTab == tab, () => onTap(tab));
  }
}

class ButtonNavigationButton extends StatelessWidget {
  final Function onTap;
  final bool isSelected;

  ButtonNavigationButton(this.isSelected, this.onTap);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      minWidth: 40,
      height: 40,
      shape: CircleBorder(),
      color: isSelected ? Color(0xFF807EFF) : Color(0xFFEEF4F6),
      onPressed: onTap,
    );
  }
}
