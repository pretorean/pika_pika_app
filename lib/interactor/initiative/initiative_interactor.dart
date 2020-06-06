import 'package:pika_pika_app/domain/post_message.dart';
import 'package:pika_pika_app/interactor/initiative/initiative_repository/initiative_repository.dart';

/// Интерактор
class InitiativeInteractor {
  final InitiativeRepository repository;

  InitiativeInteractor(this.repository);

  Future<List<PostMessage>> getPosts() {
    return repository.getPosts();
  }
}
