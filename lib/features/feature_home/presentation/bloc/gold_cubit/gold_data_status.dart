part of 'gold_cubit.dart';

@immutable
abstract class GoldDataStatus {}

class GoldDataLoading extends GoldDataStatus {}

class GoldDataCompleted extends GoldDataStatus {
  final List<GoldModel> goldResults;

  GoldDataCompleted(this.goldResults);
}

class GoldDataError extends GoldDataStatus {
  final String errorMessage;

  GoldDataError(this.errorMessage);
}
