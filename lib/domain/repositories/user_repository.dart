import 'package:skill_hub_fronend/data/models/user_stats_model.dart';

import '../entities/user.dart';

abstract class UserRepository {

  Future<User> getMe();

  Future<UserStatsModel> getStats();
}