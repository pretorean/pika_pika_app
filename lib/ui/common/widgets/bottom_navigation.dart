import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pika_pika_app/ui/app/app.dart';
import 'package:pika_pika_app/ui/res/assets.dart';
import 'package:pika_pika_app/ui/res/colors.dart';

enum HomeTab { initiatives, leaders, add, profile, map }

class BottomNavigation extends StatelessWidget {
  final HomeTab currentTab;

  final activeColor = Color(0xFF669AFE);
  final inactiveColor = Color(0xFFCADBFE);

  BottomNavigation(this.currentTab);

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 102,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
            ),
            boxShadow: [
              BoxShadow(
                  color: Color(0xFFA5B3CE),
                  blurRadius: 60,
                  offset: Offset(0, 20))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            getButton(navigator, HomeTab.initiatives, icInitiativesTab),
            getButton(navigator, HomeTab.leaders, icLeadersTab),
            getAddButton(navigator),
            getButton(navigator, HomeTab.profile, icProfileTab),
            getButton(navigator, HomeTab.map, icMapTab),
          ],
        ),
      ),
    );
  }

  Widget getAddButton(NavigatorState navigator) {
    return GestureDetector(
      onTap: () {  },
      child: Container(
        height: 60,
        width: 60,
        decoration: ShapeDecoration(
            color: Color(0xFFCADBFE), shape: CircleBorder()),
        child: Center(
            child: SvgPicture.asset(
              icAddTab,
              height: 20,
              width: 20,
            )),
      ),
    );
  }

  Widget getButton(NavigatorState navigator, HomeTab tab, String iconAsset) {
    return GestureDetector(
      onTap: () {
        onTabClick(navigator, tab);
      },
      child: SvgPicture.asset(
        iconAsset,
        color: getButtonColor(tab),
      ),
    );
  }

  Color getButtonColor(HomeTab tab) {
    final color = currentTab == tab ? activeColor : inactiveColor;
    return color;
  }

  void onTabClick(NavigatorState navigator, HomeTab tab) {
    if (tab == currentTab) return;

    switch (tab) {
      case HomeTab.initiatives:
        navigator.pushNamed(Router.initiativesScreen);
        break;
      case HomeTab.leaders:
        navigator.pushNamed(Router.leadersScreen);
        break;
      case HomeTab.add:
        break;
      case HomeTab.profile:
        navigator.pushNamed(Router.profileScreen);
        break;
      case HomeTab.map:
        break;
    }
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
