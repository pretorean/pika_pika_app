import 'package:pika_pika_app/domain/voice_way_step.dart';
import 'package:pika_pika_app/interactor/profile/profile_repository/profile_repository.dart';


class ProfileInteractor {
  final ProfileRepository repository;

  ProfileInteractor(this.repository);

  Future<List<VoiceWayStep>> getVoiceWay() {
    return repository.getVoiceWay();
  }

}