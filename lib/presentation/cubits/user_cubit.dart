import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_me_usecase.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {

  final User user;

  UserLoaded(this.user);

}

class UserError extends UserState {}

class UserCubit extends Cubit<UserState> {

  final GetMeUseCase getMeUseCase;

  UserCubit(this.getMeUseCase) : super(UserInitial());

  Future<void> fetchUser() async {

    try {

      emit(UserLoading());

      final user = await getMeUseCase();

      emit(UserLoaded(user));

    } catch (e) {

      emit(UserError());

    }

  }

}