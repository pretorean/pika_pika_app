import 'package:network/network.dart';
import 'package:pika_pika_app/domain/voice_way_step.dart';
import 'package:pika_pika_app/ui/res/assets.dart';

class ProfileRepository {
  final DioHttp _http;

  final _voidWaySteps = [
    VoiceWayStep(
      fromUserAvatar: imgUserAvatar1,
      toUserAvatar: imgUserAvatar2,
      fromUserName: 'Максим',
      toUserName: 'Екатерина',
      comment: '''Спасибо за предложение решения по 
      проблеме строительства парковки вместо детского садика! 
      Вы очень мудрый человек!  ''',
    ),
    VoiceWayStep(
      fromUserAvatar: imgUserAvatar2,
      toUserAvatar: imgUserAvatar3,
      fromUserName: 'Екатерина',
      toUserName: 'Олег',
      comment: '''Спасибо за предложение решения по 
      проблеме строительства парковки вместо детского садика! 
      Вы очень мудрый человек!  ''',
    ),
    VoiceWayStep(
      fromUserAvatar: imgUserAvatar3,
      toUserAvatar: imgUserAvatar4,
      fromUserName: 'Олег',
      toUserName: 'Юлия',
      comment: '''Спасибо за предложение решения по 
      проблеме строительства парковки вместо детского садика! 
      Вы очень мудрый человек!  ''',
    ),
    VoiceWayStep(
      fromUserAvatar: imgUserAvatar4,
      toUserAvatar: imgUserAvatar5,
      fromUserName: 'Юлия',
      toUserName: 'Кирилл',
      comment: '''Спасибо за предложение решения по 
      проблеме строительства парковки вместо детского садика! 
      Вы очень мудрый человек!  ''',
    ),

  ];

  ProfileRepository(this._http);

  Future<List<VoiceWayStep>> getVoiceWay() async {
    return Future.value(_voidWaySteps);
  }
}
