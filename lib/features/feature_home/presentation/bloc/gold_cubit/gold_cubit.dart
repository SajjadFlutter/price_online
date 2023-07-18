// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:price_online/common/resources/data_state.dart';
import 'package:price_online/features/feature_home/data/models/gold_model.dart';
import 'package:price_online/features/feature_home/repository/gold_repository.dart';

part 'gold_state.dart';
part 'gold_data_status.dart';

class GoldCubit extends Cubit<GoldState> {
  final GoldRepository goldRepository;
  GoldCubit(this.goldRepository)
      : super(GoldState(goldDataStatus: GoldDataLoading()));

  Future<void> callGoldDataEvent() async {
    // emit loading
    emit(state.copyWith(newGoldDataStatus: GoldDataLoading()));

    final DataState dataState = await goldRepository.fetchGoldData();

    if (dataState is DataSuccess) {
      // emit completed
      emit(
          state.copyWith(newGoldDataStatus: GoldDataCompleted(dataState.data)));
    }

    if (dataState is DataFailed) {
      // emit error
      emit(state.copyWith(newGoldDataStatus: GoldDataError(dataState.error!)));
    }
  }
}
