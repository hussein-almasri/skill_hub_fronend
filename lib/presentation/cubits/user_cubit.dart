import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_me_usecase.dart';
import '../../domain/usecases/get_user_stats_usecase.dart';
import '../../data/models/user_stats_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {

  final User user;

  UserLoaded(this.user);

}

class UserStatsLoaded extends UserState {

  final UserStatsModel stats;

  UserStatsLoaded(this.stats);

}

class UserError extends UserState {

  final String message;

  UserError(this.message);

}

class UserCubit extends Cubit<UserState> {

  final GetMeUseCase getMeUseCase;
  final GetUserStatsUseCase getStatsUseCase;

  User? currentUser;

  UserCubit(
    this.getMeUseCase,
    this.getStatsUseCase,
  ) : super(UserInitial());

  Future<void> fetchUser() async {

    try {

      emit(UserLoading());

      final user = await getMeUseCase();

      currentUser = user;

      emit(UserLoaded(user));

    } catch (e) {

      emit(UserError("Failed to load user"));

    }

  }

  Future<void> fetchMe() async {

    emit(UserLoading());

    try {

      final user = await getMeUseCase();

      currentUser = user;

      emit(UserLoaded(user));

    } catch (e) {

      emit(UserError("Failed to load user"));

    }

  }

  Future<void> fetchStats() async {

    emit(UserLoading());

    try {

      final stats = await getStatsUseCase();

      emit(UserStatsLoaded(stats));

    } catch (e) {

      emit(UserError("Failed to load stats"));

    }

  }

}