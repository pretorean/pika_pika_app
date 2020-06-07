import 'package:pika_pika_app/domain/leader.dart';

import 'leader_repository/leader_repository.dart';

class LeaderInteractor {
  final LeaderRepository repository;

  LeaderInteractor(this.repository);

  Future<List<Leader>> getLeaders() {
    return repository.getLeaders();
  }

  Future<Leader> getLeaderById(String postId) {
    return repository.getLeaderById(postId);
  }


}