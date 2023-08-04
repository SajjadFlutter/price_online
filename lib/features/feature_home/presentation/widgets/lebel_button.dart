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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: GestureDetector(
        onTap: () {
          // call index
          BlocProvider.of<ChangeIndexCubit>(context).changeIndexEvent(index);

          // call prices data
          /// Gold
          if (index == 0) {
            HomeScreen.labelTitle = title;
            BlocProvider.of<PricesCubit>(context).callGoldDataEvent();
          }

          /// Coin
          if (index == 1) {
            HomeScreen.labelTitle = title;
            BlocProvider.of<PricesCubit>(context).callCoinDataEvent();
          }

          /// Currency
          if (index == 2) {
            HomeScreen.labelTitle = title;
            BlocProvider.of<PricesCubit>(context).callCurrencyDataEvent();
          }

          /// Crypto
          if (index == 3) {
            HomeScreen.labelTitle = title;
            BlocProvider.of<PricesCubit>(context).callCryptoDataEvent();

            Timer.periodic(const Duration(seconds: 10), (timer) {
              BlocProvider.of<PricesCubit>(context).refreshCryptoDataEvent();
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: state == index ? primaryColor : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Text(title, style: textTheme.labelLarge),
        ),
      ),
    );
  }
}
