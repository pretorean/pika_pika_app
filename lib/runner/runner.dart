import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:pika_pika_app/ui/app/app.dart';

void run() async {
//  _initCrashlytics();
  _initLogger();
  _runApp();
}

void _runApp() {
//  runZonedGuarded(() async {
  runApp(App());
//  }, Crashlytics.instance.recordError);
}

//void _initCrashlytics() async {
//  Crashlytics.instance.enableInDevMode = false;
//  FlutterError.onError = Crashlytics.instance.recordFlutterError;
//}

void _initLogger() {
//  RemoteLogger.addStrategy(CrashlyticsRemoteLogStrategy());
  Logger.addStrategy(DebugLogStrategy());
  Logger.addStrategy(RemoteLogStrategy());
}
