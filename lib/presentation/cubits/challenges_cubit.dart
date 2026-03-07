import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/challenge.dart';
import '../../domain/usecases/get_challenges_usecase.dart';

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

  ChallengesCubit(this.getChallengesUseCase) : super(ChallengesInitial());

  Future<void> fetchChallenges() async {

    try {

      emit(ChallengesLoading());

      final challenges = await getChallengesUseCase();

      emit(ChallengesLoaded(challenges));

    } catch (e) {

      emit(ChallengesError());

    }
  }
}