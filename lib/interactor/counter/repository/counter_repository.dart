import 'package:pika_pika_app/domain/counter.dart';
import 'package:pika_pika_app/util/sp_helper.dart';

class CounterRepository {
  static const String KEY_COUNTER = 'KEY_COUNTER';

  final PreferencesHelper _preferencesHelper;

  CounterRepository(this._preferencesHelper);

  void setCounter(Counter c) {
    if (c == null) return;
    _preferencesHelper.set(KEY_COUNTER, c.count);
  }

  Future<Counter> getCounter() {
    return _preferencesHelper
        .get(KEY_COUNTER, 0)
        .then(
          (i) => Counter(i ?? 0),
        )
        .catchError(
      (e) {
        print('DEV_ERROR ${e.toString()}');
        return Counter(0);
      },
    );
  }
}
