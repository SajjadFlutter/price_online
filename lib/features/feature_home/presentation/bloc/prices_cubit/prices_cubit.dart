// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:price_online/common/resources/data_state.dart';
import 'package:price_online/features/feature_home/repository/prices_repository.dart';

part 'prices_state.dart';
part 'prices_data_status.dart';

class PricesCubit extends Cubit<PricesState> {
  final PricesRepository coinRepository;
  PricesCubit(this.coinRepository)
      : super(PricesState(pricesDataStatus: PricesDataLoading()));

  // Gold
  Future<void> callGoldDataEvent() async {
    // emit loading
    emit(state.copyWith(newPricesDataStatus: PricesDataLoading()));

    final DataState dataState = await coinRepository.fetchGoldData();

    if (dataState is DataSuccess) {
      // emit completed
      emit(state.copyWith(
          newPricesDataStatus: PricesDataCompleted(dataState.data)));
    }

    if (dataState is DataFailed) {
      // emit error
      emit(state.copyWith(
          newPricesDataStatus: PricesDataError(dataState.error!)));
    }
  }

  // Coin
  Future<void> callCoinDataEvent() async {
    // emit loading
    emit(state.copyWith(newPricesDataStatus: PricesDataLoading()));

    final DataState dataState = await coinRepository.fetchCoinData();

    if (dataState is DataSuccess) {
      // emit completed
      emit(state.copyWith(
          newPricesDataStatus: PricesDataCompleted(dataState.data)));
    }

    if (dataState is DataFailed) {
      // emit error
      emit(state.copyWith(
          newPricesDataStatus: PricesDataError(dataState.error!)));
    }
  }

  // Currency
  Future<void> callCurrencyDataEvent() async {
    // emit loading
    emit(state.copyWith(newPricesDataStatus: PricesDataLoading()));

    final DataState dataState = await coinRepository.fetchCurrencyData();

    if (dataState is DataSuccess) {
      // emit completed
      emit(state.copyWith(
          newPricesDataStatus: PricesDataCompleted(dataState.data)));
    }

    if (dataState is DataFailed) {
      // emit error
      emit(state.copyWith(
          newPricesDataStatus: PricesDataError(dataState.error!)));
    }
  }

  // Crypto
  Future<void> callCryptoDataEvent() async {
    // emit loading
    emit(state.copyWith(newPricesDataStatus: PricesDataLoading()));

    final DataState dataState = await coinRepository.fetchCryptoData();

    if (dataState is DataSuccess) {
      // emit completed
      emit(state.copyWith(
          newPricesDataStatus: PricesDataCompleted(dataState.data)));
    }

    if (dataState is DataFailed) {
      // emit error
      emit(state.copyWith(
          newPricesDataStatus: PricesDataError(dataState.error!)));
    }
  }
}
