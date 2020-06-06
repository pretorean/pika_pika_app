import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pika_pika_app/ui/res/assets.dart';
import 'package:pika_pika_app/ui/res/colors.dart';
import 'package:pika_pika_app/ui/screen/home/home_tab.dart';

class BottomNavigation extends StatelessWidget {
  final HomeTab currentTab;
  final Function(HomeTab tab) onTap;

  final activeColor = Color(0xFF669AFE);
  final inactiveColor = Color(0xFFCADBFE);

  BottomNavigation(this.currentTab, this.onTap);

  @override
  Widget build(BuildContext context) {
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
            SvgPicture.asset(icInitiativesTab,
                color: getButtonColor(HomeTab.initiatives)),
            SvgPicture.asset(icLeadersTab,
                color: getButtonColor(HomeTab.leaders)),
            Container(
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
            SvgPicture.asset(icProfileTab,
                color: getButtonColor(HomeTab.profile)),
            SvgPicture.asset(icMapTab, color: getButtonColor(HomeTab.map))
          ],
        ),
      ),
    );
  }

  Color getButtonColor(HomeTab tab) {
    final color = currentTab == tab ? activeColor : inactiveColor;
    return color;
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
