import 'package:network/network.dart';
import 'package:pika_pika_app/domain/leader.dart';
import 'package:pika_pika_app/interactor/common/exceptions.dart';

class LeaderRepository {
  final DioHttp _http;

  final _leaders = [
    Leader(
      id: '1',
      firstName: 'Ренат',
      lastName: 'Шахматов',
      voices: '100',
    ),
    Leader(
      id: '2',
      firstName: 'Илон',
      lastName: 'Маск',
      voices: '80',
    ),
    Leader(
      id: '3',
      firstName: 'Стив',
      lastName: 'Джобс',
      voices: '70',
    ),
    Leader(
      id: '4',
      firstName: 'Марк',
      lastName: 'Дакаскас',
      voices: '60',
    ),
    Leader(
      id: '5',
      firstName: 'Николай',
      lastName: 'Костер-Вальдау',
      voices: '50',
    ),
  ];

  LeaderRepository(this._http);

  Future<List<Leader>> getLeaders() async {
    return Future.value(_leaders);
  }

  Future<Leader> getLeaderById(String leaderId) async {
    final leader = _leaders.firstWhere((leader) => leader.id == leaderId);

    if (leader != null) {
      return Future.value(leader);
    } else {
      throw NotFoundException('Лидер не найдена');
    }
  }
}
