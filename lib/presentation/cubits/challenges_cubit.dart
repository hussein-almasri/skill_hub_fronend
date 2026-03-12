import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/challenge.dart';
import '../../domain/usecases/get_challenges_usecase.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';

abstract class ChallengesState {}

class ChallengesInitial extends ChallengesState {}

class ChallengesLoading extends ChallengesState {}

class ChallengesLoaded extends ChallengesState {
  final List<Challenge> challenges;

  ChallengesLoaded(this.challenges);
}

class ChallengesError extends ChallengesState {}

class ChallengesCubit extends Cubit<ChallengesState> {

  final GetChallengesUseCase getChallengesUseCase;

  final Set<int> solvedChallenges = {};

  final Dio dio = DioClient().dio;

  ChallengesCubit(this.getChallengesUseCase) : super(ChallengesInitial());

  Future<void> fetchChallenges() async {

    try {

      emit(ChallengesLoading());

      final challenges = await getChallengesUseCase();

      await _fetchSolvedChallenges();

      emit(ChallengesLoaded(challenges));

    } catch (e) {

      emit(ChallengesError());

    }
  }

  Future<void> _fetchSolvedChallenges() async {

    try {

      final response = await dio.get(
        "${ApiConstants.baseUrl}/users/solved-challenges",
      );

      final List data = response.data;

      solvedChallenges.clear();

      for (var id in data) {
        solvedChallenges.add(id);
      }

    } catch (_) {}
  }

  void markSolved(int challengeId) {

    solvedChallenges.add(challengeId);

    if (state is ChallengesLoaded) {

      emit(ChallengesLoaded((state as ChallengesLoaded).challenges));

    }

  }

}