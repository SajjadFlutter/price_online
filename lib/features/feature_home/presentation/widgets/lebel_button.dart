import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_online/common/bloc/change_index/change_index_cubit.dart';
import 'package:price_online/features/feature_home/presentation/bloc/prices_cubit/prices_cubit.dart';
import 'package:price_online/features/feature_home/presentation/screens/home_screen.dart';

class LebelButton extends StatelessWidget {
  const LebelButton({
    super.key,
    required this.primaryColor,
    required this.textTheme,
    required this.state,
    required this.index,
    required this.title,
  });

  final Color primaryColor;
  final TextTheme textTheme;
  final int state;
  final int index;
  final String title;

  static Timer _timer = Timer(const Duration(seconds: 10), () {});

  @override
  Widget build(BuildContext context) {
    void startTimer(Function refreshFunction) {
      const duration = Duration(seconds: 30);
      _timer = Timer.periodic(duration, (timer) {
        // کدی که برای هر بار اجرا شدن تایمر انجام میشود
        refreshFunction();
      });
    }

    void stopTimer() {
      _timer.cancel();
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 10.0,
        right: index == 0 ? 10.0 : 0.0,
      ),
      child: GestureDetector(
        onTap: () {
          // call index
          BlocProvider.of<ChangeIndexCubit>(context).changeIndexEvent(index);

          // call prices data
          /// Gold
          if (index == 0) {
            HomeScreen.labelTitle = title;
            BlocProvider.of<PricesCubit>(context).callGoldDataEvent();

            stopTimer();

            startTimer(() {
              BlocProvider.of<PricesCubit>(context).refreshGoldDataEvent();
            });
          }

          /// Coin
          if (index == 1) {
            HomeScreen.labelTitle = title;
            BlocProvider.of<PricesCubit>(context).callCoinDataEvent();

            stopTimer();

            startTimer(() {
              BlocProvider.of<PricesCubit>(context).refreshCoinDataEvent();
            });
          }

          /// Currency
          if (index == 2) {
            HomeScreen.labelTitle = title;
            BlocProvider.of<PricesCubit>(context).callCurrencyDataEvent();

            stopTimer();

            startTimer(() {
              BlocProvider.of<PricesCubit>(context).refreshCurrencyDataEvent();
            });
          }

          /// Crypto
          if (index == 3) {
            HomeScreen.labelTitle = title;
            BlocProvider.of<PricesCubit>(context).callCryptoDataEvent();

            stopTimer();

            startTimer(() {
              BlocProvider.of<PricesCubit>(context).refreshCryptoDataEvent();
            });
          }
        },
        child: Container(
          // margin: EdgeInsets.s,
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: state == index ? primaryColor : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Text(
            title,
            style: state == index
                ? const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  )
                : textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
