import '../repositories/user_repository.dart';

class GetUserStatsUseCase {

  final UserRepository repository;

  GetUserStatsUseCase(this.repository);

  Future call() {
    return repository.getStats();
  }

}