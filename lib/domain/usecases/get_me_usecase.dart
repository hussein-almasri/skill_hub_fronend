import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetMeUseCase {

  final UserRepository repository;

  GetMeUseCase(this.repository);

  Future<User> call() {

    return repository.getMe();

  }

}