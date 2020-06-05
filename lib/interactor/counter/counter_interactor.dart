import 'package:pika_pika_app/domain/counter.dart';
import 'package:pika_pika_app/interactor/counter/repository/counter_repository.dart';
import 'package:rxdart/rxdart.dart';

class CounterInteractor {
  Counter _counter;

  final CounterRepository _counterRepository;

  final PublishSubject<Counter> _subject = PublishSubject();

  Stream<Counter> get counterObservable => _subject.stream;

  CounterInteractor(this._counterRepository) {
    _subject.listen(_counterRepository.setCounter);

    _counterRepository.getCounter().then((c) {
      _counter = c;
      _subject.add(_counter);
    });
  }

  void incrementCounter() {
    var c = _counter.count + 1;
    _counter = Counter(c);
    _subject.add(_counter);
  }
}
