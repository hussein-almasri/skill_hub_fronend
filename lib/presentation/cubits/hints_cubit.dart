import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/hints_remote_datasource.dart';
import '../../data/models/hint_model.dart';

part 'hints_state.dart';

class HintsCubit extends Cubit<HintsState> {

  final HintsRemoteDatasource datasource;

  HintsCubit(this.datasource) : super(HintsInitial());

  Future<void> fetchHints(int challengeId) async {

    emit(HintsLoading());

    try {

      final hints = await datasource.getHints(challengeId);

      emit(HintsLoaded(hints));

    } catch (e) {

      emit(HintsError());

    }

  }

  /// 🔹 Unlock Hint
  Future<String> unlockHint(int hintId) async {

    final result = await datasource.unlockHint(hintId);

    return result;

  }

}