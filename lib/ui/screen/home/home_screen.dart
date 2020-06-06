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
      backgroundColor: Color(0xFFDBE8FF),
      key: Injector.of<HomeScreenComponent>(context).component.scaffoldKey,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        BottomNavigation(),
      ],
    );
  }
}

//class Header extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Positioned(
//      top: 0,
//      left: 0,
//      right: 0,
//      child: Container(
//        height: 170,
//        decoration: BoxDecoration(
//          color: Color(0xFFF8FBFB),
//          borderRadius: BorderRadius.only(
//            bottomLeft: Radius.circular(20),
//            bottomRight: Radius.circular(20),
//          ),
//        ),
//      ),
//    );
//  }
//}


class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  final int tabNumber = 4;
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 102,
        decoration: BoxDecoration(
          color: Color(0xFFF8FBFB),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            for (var i = 0; i < tabNumber; i++) createButton(i)
          ],
        ),
      ),
    );
  }



  ButtonNavigationButton createButton(int index) {
    return ButtonNavigationButton(_currentTab == index, () => _setCurrentTab(index));
  }

  void _setCurrentTab(int tab) {
    setState(() {
      _currentTab = tab;
    });
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

