import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/domain/post_message.dart';
import 'package:pika_pika_app/ui/screen/initiative_detail/di/initiative_detail_screen_component.dart';
import 'package:pika_pika_app/ui/screen/initiative_detail/initiative_detail_wm.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

class InitiativeDetail extends MwwmWidget<InitiativeDetailComponent> {
  InitiativeDetail([
    WidgetModelBuilder widgetModelBuilder = createInitiativeDetailWidgetModel,
  ]) : super(
          dependenciesBuilder: (context) => InitiativeDetailComponent(context),
          widgetStateBuilder: () => _InitiativeDetailState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _InitiativeDetailState extends WidgetState<InitiativeDetailWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:
          Injector.of<InitiativeDetailComponent>(context).component.scaffoldKey,
      body: SafeArea(
        child: EntityStateBuilder<PostMessage>(
          streamedState: wm.dataState,
          errorChild: Center(
            child: CircularProgressIndicator(),
          ),
          child: (context, post) {
            return _buildBody();
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildLogoImage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoImage() {
    return Icon(
      Icons.lightbulb_outline,
      size: 150,
      color: Colors.indigo,
    );
  }
}
