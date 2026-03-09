part of 'hints_cubit.dart';

abstract class HintsState {}

class HintsInitial extends HintsState {}

class HintsLoading extends HintsState {}

class HintsLoaded extends HintsState {

  final List<HintModel> hints;

  HintsLoaded(this.hints);

}

class HintsError extends HintsState {}