import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/create_challenge_model.dart';
import '../../domain/usecases/create_challenge_usecase.dart';
import '../../domain/usecases/delete_challenge_usecase.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {

  final CreateChallengeUseCase createChallengeUseCase;
  final DeleteChallengeUseCase deleteChallengeUseCase;

  AdminCubit(
    this.createChallengeUseCase,
    this.deleteChallengeUseCase,
  ) : super(AdminInitial());

  Future<void> createChallenge(CreateChallengeModel model) async {

    emit(AdminLoading());

    try {

      await createChallengeUseCase(model);

      emit(AdminSuccess());

    } catch (e) {

      emit(AdminError("Failed to create challenge"));

    }

  }

  /// 🔹 Update Challenge
  Future<void> updateChallenge(
    int id,
    Map<String, dynamic> data,
  ) async {

    emit(AdminLoading());

    try {

      await createChallengeUseCase.updateChallenge(
        id,
        data,
      );

      emit(AdminSuccess());

    } catch (e) {

      emit(AdminError("Failed to update challenge"));

    }

  }

  Future<void> deleteChallenge(int id) async {

    emit(AdminLoading());

    try {

      await deleteChallengeUseCase(id);

      emit(AdminSuccess());

    } catch (e) {

      emit(AdminError("Failed to delete"));

    }

  }
  Future<void> createHint(
  int challengeId,
  String hintText,
  int cost,
) async {

  try {

    await createChallengeUseCase.repository.remote.dio.post(
      "/hints/$challengeId",
      data: {
        "hint_text": hintText,
        "cost": cost,
      },
    );

  } catch (e) {

    emit(AdminError("Failed to create hint"));

  }

}

}