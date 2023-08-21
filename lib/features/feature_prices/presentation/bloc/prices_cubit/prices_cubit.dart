// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:price_online/common/resources/data_state.dart';
import 'package:price_online/features/feature_prices/repository/prices_repository.dart';

part 'prices_state.dart';
part 'prices_data_status.dart';

class PricesCubit extends Cubit<PricesState> {
  final PricesRepository pricesRepository;
  PricesCubit(this.pricesRepository)
      : super(PricesState(pricesDataStatus: PricesDataLoading()));

  // Gold Data
  Future<void> callGoldDataEvent() async {
    // emit loading
    emit(state.copyWith(newPricesDataStatus: PricesDataLoading()));

    final DataState dataState = await pricesRepository.fetchGoldData();

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

  // Refresh Gold Data
  Future<void> refreshGoldDataEvent() async {
    final DataState dataState = await pricesRepository.fetchGoldData();

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

  // Coin Data
  Future<void> callCoinDataEvent() async {
    // emit loading
    emit(state.copyWith(newPricesDataStatus: PricesDataLoading()));

    final DataState dataState = await pricesRepository.fetchCoinData();

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

  // Refresh Coin Data
  Future<void> refreshCoinDataEvent() async {
    final DataState dataState = await pricesRepository.fetchCoinData();

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

  // Currency Data
  Future<void> callCurrencyDataEvent() async {
    // emit loading
    emit(state.copyWith(newPricesDataStatus: PricesDataLoading()));

    final DataState dataState = await pricesRepository.fetchCurrencyData();

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

  // Refresh Currency Data
  Future<void> refreshCurrencyDataEvent() async {
    final DataState dataState = await pricesRepository.fetchCurrencyData();

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

  // Crypto Data
  Future<void> callCryptoDataEvent() async {
    // emit loading
    emit(state.copyWith(newPricesDataStatus: PricesDataLoading()));

    final DataState dataState = await pricesRepository.fetchCryptoData();

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

  // Refresh Crypto Data
  Future<void> refreshCryptoDataEvent() async {
    final DataState dataState = await pricesRepository.fetchCryptoData();

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
