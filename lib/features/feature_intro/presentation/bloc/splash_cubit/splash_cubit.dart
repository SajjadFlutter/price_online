import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_online/features/feature_intro/repository/splash_repository.dart';

part 'splash_state.dart';
part 'connection_status.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashRepository splashRepository = SplashRepository();
  SplashCubit() : super(SplashState(connectionStatus: ConnectionInitial()));

  void checkConnectionEvent() async {
    emit(state.copyWith(newConnectionStatus: ConnectionInitial()));

    final bool isConnect = await splashRepository.checkConnectivity();

    if (isConnect) {
      emit(state.copyWith(newConnectionStatus: ConnectionOn()));
    } else {
      emit(state.copyWith(newConnectionStatus: ConnectionOff()));
    }
  }
}
