import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/config/env/env.dart';
import 'package:pika_pika_app/domain/debug_options.dart';
import 'package:pika_pika_app/ui/app/app_wm.dart';
import 'package:pika_pika_app/ui/app/di/app.dart';
import 'package:pika_pika_app/ui/res/styles.dart';
import 'package:pika_pika_app/ui/screen/initiative_detail/initiative_detail_route.dart';
import 'package:pika_pika_app/ui/screen/initiatives/initiatives_route.dart';
import 'package:pika_pika_app/ui/screen/leaders/leaders_route.dart';
import 'package:pika_pika_app/ui/screen/login/login_route.dart';
import 'package:pika_pika_app/ui/screen/register/register_route.dart';
import 'package:pika_pika_app/ui/screen/splash_screen/splash_route.dart';
import 'package:pika_pika_app/ui/screen/welcome_screen/welcome_route.dart';
import 'package:pika_pika_app/util/custom_error_widget.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

// todo оставить здесь только необходимые маршруты
class Router {
  static const String root = '/';
  static const String splashScreen = '/splash';
  static const String registerScreen = '/register';
  static const String loginScreen = '/login';
  static const String initiativesScreen = '/initiatives';
  static const String initiativesDetailScreen = '/initiativeDetail';
  static const String leadersScreen = '/leadersScreen';

  static final Map<String, Route Function(dynamic data)> routes = {
    Router.root: (data) => WelcomeScreenRoute(),
    Router.splashScreen: (data) => SplashScreenRoute(),
    Router.loginScreen: (data) => LoginScreenRoute(),
    Router.registerScreen: (data) => RegisterScreenRoute(),
    Router.initiativesScreen: (data) => InitiativesScreenRoute(),
    Router.initiativesDetailScreen: (data) => InitiativeDetailScreenRoute(postId: data),
    Router.leadersScreen: (data) => LeadersScreenRoute()
  };
}

/// Виджет приложения
class App extends MwwmWidget<AppComponent> {
  App([
    WidgetModelBuilder widgetModelBuilder = createAppWidgetModel,
  ]) : super(
          dependenciesBuilder: (context) => AppComponent(context),
          widgetStateBuilder: () => _AppState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _AppState extends WidgetState<AppWidgetModel> {
  @override
  void initState() {
    super.initState();
    Environment.instance().addListener(_setStateOnChangeConfig);
  }

  @override
  void dispose() {
    Environment.instance().removeListener(_setStateOnChangeConfig);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Injector.of<AppComponent>(context).component.navigator,
      builder: (BuildContext context, Widget widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return CustomErrorWidget(
            context: context,
            error: errorDetails,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            errorMessage: 'test',
          );
        };
        return widget;
      },
      theme: themeData,
      showPerformanceOverlay: getDebugConfig().showPerformanceOverlay,
      debugShowMaterialGrid: getDebugConfig().debugShowMaterialGrid,
      checkerboardRasterCacheImages:
          getDebugConfig().checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: getDebugConfig().checkerboardOffscreenLayers,
      showSemanticsDebugger: getDebugConfig().showSemanticsDebugger,
      debugShowCheckedModeBanner: getDebugConfig().debugShowCheckedModeBanner,
      initialRoute: Router.splashScreen,
      onGenerateRoute: (RouteSettings rs) =>
          Router.routes[rs.name](rs.arguments),
    );
  }

  void _setStateOnChangeConfig() {
    setState(() {});
  }

  DebugOptions getDebugConfig() => Environment.instance().config.debugOptions;
}
