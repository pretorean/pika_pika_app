import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:injector/injector.dart';
import 'package:pika_pika_app/interactor/token/auth_token_storage.dart';
import 'package:pika_pika_app/ui/app/app.dart';
import 'package:pika_pika_app/ui/screen/splash_screen/di/splash_screen_component.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// Билдер для [WelcomeScreenWidgetModel].
SplashScreenWidgetModel createSplashScreenWidgetModel(BuildContext context) {
  var component = Injector.of<SplashScreenComponent>(context).component;

  return SplashScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.authTokenStorage,
  );
}

/// [WidgetModel] для экрана <SplashScreen>
class SplashScreenWidgetModel extends WidgetModel {
  final widgets.NavigatorState _navigator;

  final AuthTokenStorage _tokenStorage;

  SplashScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._tokenStorage,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();
//    if (Platform.isMacOS) {
//      DesktopWindow.setMaxWindowSize(Size(375, 812));
//      DesktopWindow.setMinWindowSize(Size(375, 812));
//    }
    _loadApp();
  }

  void _loadApp() async {
    doFuture(
      initApp(),
      (bool isAuth) {
        if (isAuth) {
          _openScreen(Router.initiativesScreen);
        } else {
          _openScreen(Router.loginScreen);
        }
      },
    );
  }

  void _openScreen(String routeName) {
    _navigator.pushReplacementNamed(routeName);
  }

  Future<bool> initApp() {
    return _tokenStorage.tryRestoreAuthorization();
  }
}
