import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/ui/res/assets.dart';
import 'package:pika_pika_app/ui/res/colors.dart';
import 'package:pika_pika_app/ui/res/strings/strings.dart';
import 'package:pika_pika_app/ui/screen/initiatives/initiatives_filter.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'di/initiatives_screen_component.dart';
import 'initiatives_wm.dart';

class InitiativesScreen extends MwwmWidget<InitiativesScreenComponent> {
  InitiativesScreen([
    WidgetModelBuilder widgetModelBuilder = createInitiativesScreenWidgetModel,
  ]) : super(
          dependenciesBuilder: (context) => InitiativesScreenComponent(context),
          widgetStateBuilder: () => _InitiativesScreenState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _InitiativesScreenState
    extends WidgetState<InitiativesScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDBE8FF),
      key: Injector.of<InitiativesScreenComponent>(context)
          .component
          .scaffoldKey,
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {

    return Stack(
      children: <Widget>[
        Header(wm),
      ],
    );
  }
}

class Header extends StatelessWidget {

  final InitiativesScreenWidgetModel wm;

  Header(this.wm);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 20,
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Здравствуйте, Максим',
                          style: TextStyle(
                              color: blue1,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          initiativesScreenTitle,
                          style: TextStyle(
                              color: text1,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  SvgPicture.asset(icSearch),
                  SizedBox(width: 10),
                  SvgPicture.asset(icQrCode),
                  SizedBox(width: 10),
                  SvgPicture.asset(icSettings),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              StreamedStateBuilder<InitiativesFilter>(
                streamedState: wm.filterState,
                builder: (context, filter) {
                  return  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FilterButton(initiativesFilterButtonActive, filter == InitiativesFilter.active, () {
                        wm.filterAction.accept(InitiativesFilter.active);
                      }),
                      SizedBox(width: 10,),
                      FilterButton(initiativesFilterButtonSolved, filter == InitiativesFilter.solved, () {
                        wm.filterAction.accept(InitiativesFilter.solved);
                      }),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}



class FilterButton extends StatelessWidget {
  final String title;
  final bool checked;
  final Function onPressed;

  FilterButton(this.title, this.checked, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        constraints: BoxConstraints(minHeight: 35, minWidth: 110),
        decoration: BoxDecoration(
          color: checked ? yellow1 : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: checked
              ? Border.fromBorderSide(BorderSide.none)
              : Border.all(width: 1, color: Color(0xFFDBE8FF)),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: checked ? Color(0xFF2D2314) : Color(0xFFDBE8FF),
            ),
          ),
        ),
      ),
    );
  }
}
