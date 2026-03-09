import '../../data/models/user_stats_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserStatsLoaded extends UserState {

  final UserStatsModel stats;

  UserStatsLoaded(this.stats);

}

class UserError extends UserState {

  final String message;

  UserError(this.message);

}