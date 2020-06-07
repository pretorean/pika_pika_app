import 'package:network/network.dart';
import 'package:pika_pika_app/domain/leader.dart';
import 'package:pika_pika_app/interactor/common/exceptions.dart';
import 'package:pika_pika_app/ui/res/assets.dart';

class LeaderRepository {
  final DioHttp _http;

  final _leaders = [
    Leader(
      id: '1',
      firstName: 'Иван',
      lastName: 'Иваненко',
      voices: '100',
      avatar: imgUserAvatar1,
    ),
    Leader(
      id: '2',
      firstName: 'Екатерина',
      lastName: 'Весёлая',
      voices: '80',
      avatar: imgUserAvatar2,
    ),
    Leader(
      id: '3',
      firstName: 'Стив',
      lastName: 'Джобс',
      voices: '70',
      avatar: imgUserAvatar3,
    ),
    Leader(
      id: '4',
      firstName: 'Юлия',
      lastName: 'Бессонная',
      voices: '60',
      avatar: imgUserAvatar4,
    ),
    Leader(
      id: '5',
      firstName: 'Николай',
      lastName: 'Костер-Вальдау',
      voices: '50',
      avatar: imgUserAvatar5,
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
