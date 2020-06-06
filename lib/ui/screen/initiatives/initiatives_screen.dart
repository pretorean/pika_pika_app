import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/ui/res/colors.dart';
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }
}
