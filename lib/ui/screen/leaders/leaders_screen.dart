import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:injector/injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'di/leaders_screen_component.dart';
import 'leaders_wm.dart';



class LeadersScreen extends MwwmWidget<LeadersScreenComponent> {
  LeadersScreen([
    WidgetModelBuilder widgetModelBuilder = createLeadersScreenWidgetModel,
  ]) : super(
    dependenciesBuilder: (context) => LeadersScreenComponent(context),
    widgetStateBuilder: () => _LeadersScreenState(),
    widgetModelBuilder: widgetModelBuilder,
  );
}

class _LeadersScreenState
    extends WidgetState<LeadersScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDBE8FF),
      key: Injector
          .of<LeadersScreenComponent>(context)
          .component
          .scaffoldKey,
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Container(

    );
  }

}

