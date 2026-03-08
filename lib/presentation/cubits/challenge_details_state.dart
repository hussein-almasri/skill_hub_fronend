part of 'challenge_details_cubit.dart';

abstract class ChallengeDetailsState {}

class ChallengeDetailsInitial extends ChallengeDetailsState {}

class ChallengeDetailsLoading extends ChallengeDetailsState {}

class ChallengeDetailsLoaded extends ChallengeDetailsState {
  final Challenge challenge;

  ChallengeDetailsLoaded(this.challenge);
}

class ChallengeDetailsError extends ChallengeDetailsState {
  final String message;

  ChallengeDetailsError(this.message);
}