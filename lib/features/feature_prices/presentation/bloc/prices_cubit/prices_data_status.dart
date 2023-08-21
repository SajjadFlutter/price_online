part of 'prices_cubit.dart';

@immutable
abstract class PricesDataStatus {}

class PricesDataLoading extends PricesDataStatus {}

class PricesDataCompleted extends PricesDataStatus {
  final List modelResults;

  PricesDataCompleted(this.modelResults);
}

class PricesDataError extends PricesDataStatus {
  final String errorMessage;

  PricesDataError(this.errorMessage);
}
