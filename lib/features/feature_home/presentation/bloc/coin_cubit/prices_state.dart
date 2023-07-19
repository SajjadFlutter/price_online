part of 'prices_cubit.dart';

class PricesState {
  final PricesDataStatus pricesDataStatus;

  PricesState({required this.pricesDataStatus});

  PricesState copyWith({required PricesDataStatus? newPricesDataStatus}) {
    return PricesState(pricesDataStatus: newPricesDataStatus ?? pricesDataStatus);
  }
}
