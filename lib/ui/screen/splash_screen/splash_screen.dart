
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/ui/screen/splash_screen/di/splash_screen_component.dart';
import 'package:pika_pika_app/ui/screen/splash_screen/splash_wm.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// Splash screen
class SplashScreen extends MwwmWidget<SplashScreenComponent> {
  SplashScreen([
    WidgetModelBuilder widgetModelBuilder = createSplashScreenWidgetModel,
  ]) : super(
    dependenciesBuilder: (context) => SplashScreenComponent(context),
    widgetStateBuilder: () => _SplashScreenState(),
    widgetModelBuilder: widgetModelBuilder,
  );
}

class _SplashScreenState extends WidgetState<SplashScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<SplashScreenComponent>(context).component.scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.lightbulb_outline,
              size: 150,
              color: Colors.indigo,
            ),
            Text(
              'Add Logo Here',
              style: TextStyle(
                fontSize: 30,
                color: Colors.indigo,
              ),
            )
          ],
        ),
      ),
    );
  }
}
