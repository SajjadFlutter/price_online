part of 'gold_cubit.dart';

class GoldState {
  final GoldDataStatus goldDataStatus;

  GoldState({required this.goldDataStatus});

  GoldState copyWith({required GoldDataStatus? newGoldDataStatus}) {
    return GoldState(goldDataStatus: newGoldDataStatus ?? goldDataStatus);
  }
}
