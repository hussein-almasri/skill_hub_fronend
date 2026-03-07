import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/leaderboard_user.dart';
import '../../domain/usecases/get_leaderboard_usecase.dart';

abstract class LeaderboardState {}

class LeaderboardInitial extends LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardLoaded extends LeaderboardState {

  final List<LeaderboardUser> users;

  LeaderboardLoaded(this.users);

}

class LeaderboardError extends LeaderboardState {}

class LeaderboardCubit extends Cubit<LeaderboardState> {

  final GetLeaderboardUseCase getLeaderboardUseCase;

  LeaderboardCubit(this.getLeaderboardUseCase)
      : super(LeaderboardInitial());

  Future<void> fetchLeaderboard() async {

    try {

      emit(LeaderboardLoading());

      final users = await getLeaderboardUseCase();

      emit(LeaderboardLoaded(users));

    } catch (e) {

      emit(LeaderboardError());

    }

  }

}