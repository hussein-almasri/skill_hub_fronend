import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/challenge.dart';
import '../../domain/usecases/get_challenge_details_usecase.dart';

part 'challenge_details_state.dart';

class ChallengeDetailsCubit extends Cubit<ChallengeDetailsState> {

  final GetChallengeDetailsUseCase getChallengeDetails;

  ChallengeDetailsCubit(this.getChallengeDetails)
      : super(ChallengeDetailsInitial());

  Future<void> fetchChallenge(int id) async {

    emit(ChallengeDetailsLoading());

    try {

      final challenge = await getChallengeDetails(id);

      emit(ChallengeDetailsLoaded(challenge));

    } catch (e) {

      emit(ChallengeDetailsError("Failed to load challenge"));

    }
  }
}