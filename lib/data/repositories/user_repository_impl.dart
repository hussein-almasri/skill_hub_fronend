import 'package:skill_hub_fronend/data/models/user_stats_model.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {

  final UserRemoteDatasource remoteDatasource;

  UserRepositoryImpl(this.remoteDatasource);

  @override
  Future<User> getMe() {

    return remoteDatasource.getMe();

  }
  
  Future<UserStatsModel> getStats() async {
  return await remoteDatasource.getStats();
}

}