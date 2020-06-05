import 'package:pika_pika_app/config/build_types.dart';
import 'package:pika_pika_app/config/config.dart';
import 'package:pika_pika_app/config/env/env.dart';
import 'package:pika_pika_app/domain/debug_options.dart';
import 'package:pika_pika_app/interactor/common/urls.dart';
import 'package:pika_pika_app/runner/runner.dart';

//Main entry point of app
void main() async {
  Environment.init(
    buildType: BuildType.debug,
    config: Config(
      url: Url.testUrl,
      proxyUrl: Url.devProxyUrl,
      debugOptions: DebugOptions(
        debugShowCheckedModeBanner: true,
      ),
    ),
  );

  run();
}
