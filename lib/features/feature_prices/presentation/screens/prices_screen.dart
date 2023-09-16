// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_online/common/helper/decimal_rounder.dart';
import 'package:price_online/features/feature_prices/presentation/bloc/prices_cubit/prices_cubit.dart';
import 'package:price_online/features/feature_prices/presentation/widgets/price_item.dart';
import 'package:price_online/locator.dart';
import 'package:price_online/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PricesScreen extends StatefulWidget {
  const PricesScreen({super.key});

  static String categoryTitle = 'طلا';
  // label categories
  static final categoryTitles = [
    'طلا',
    'سکه',
    'ارز مرجع',
    'ارز دیجیتال',
  ];

  // Timer for update
  static Timer _timer = Timer(const Duration(seconds: 10), () {});

  static void stopTimer() {
    PricesScreen._timer.cancel();
  }

  @override
  State<PricesScreen> createState() => _PricesScreenState();
}

class _PricesScreenState extends State<PricesScreen> {
  @override
  void dispose() {
    PricesScreen.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // change statusbar color
    // Show state for dark mode or light mode
    var isDarkMode =
        locator<SharedPreferences>().getBool('isDarkMode') ?? false;

    if (isDarkMode) {
      MyApp.changeColor(Colors.transparent, Brightness.light);
    } else {
      MyApp.changeColor(Colors.transparent, Brightness.dark);
    }
    // theme
    var textTheme = Theme.of(context).textTheme;
    var primaryColor = Theme.of(context).primaryColor;
    var secondaryHeaderColor = Theme.of(context).secondaryHeaderColor;
    var cardColor = Theme.of(context).cardColor;

    // Timer for update
    void startTimer(Function refreshFunction) {
      const duration = Duration(seconds: 20);
      PricesScreen._timer = Timer.periodic(duration, (timer) {
        // کدی که برای هر بار اجرا شدن تایمر انجام میشود
        refreshFunction();
      });
    }

    // call api
    void callApiForPrices() {
      switch (PricesScreen.categoryTitle) {
        case 'طلا':
          BlocProvider.of<PricesCubit>(context).callGoldDataEvent();
          PricesScreen.stopTimer();
          startTimer(() {
            BlocProvider.of<PricesCubit>(context).refreshGoldDataEvent();
          });
          break;
        case 'سکه':
          BlocProvider.of<PricesCubit>(context).callCoinDataEvent();
          PricesScreen.stopTimer();
          startTimer(() {
            BlocProvider.of<PricesCubit>(context).refreshCoinDataEvent();
          });
          break;
        case 'ارز مرجع':
          BlocProvider.of<PricesCubit>(context).callCurrencyDataEvent();
          PricesScreen.stopTimer();
          startTimer(() {
            BlocProvider.of<PricesCubit>(context).refreshCurrencyDataEvent();
          });
          break;
        case 'ارز دیجیتال':
          BlocProvider.of<PricesCubit>(context).callCryptoDataEvent();
          PricesScreen.stopTimer();
          startTimer(() {
            BlocProvider.of<PricesCubit>(context).refreshCryptoDataEvent();
          });
          break;
        case 'نفت و انرژی':
          BlocProvider.of<PricesCubit>(context).callEnergyDataEvent();
          PricesScreen.stopTimer();
          startTimer(() {
            BlocProvider.of<PricesCubit>(context).refreshEnergyDataEvent();
          });
          break;
        case 'فلزات گرانبها':
          BlocProvider.of<PricesCubit>(context).callMetalDataEvent();
          PricesScreen.stopTimer();
          startTimer(() {
            BlocProvider.of<PricesCubit>(context).refreshMetalDataEvent();
          });
          break;
        default:
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          // call api
          callApiForPrices();

          return Column(
            children: [
              // appbar
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: secondaryHeaderColor,
                            ),
                          ),
                        ),
                        // title appbar
                        Text(
                          'قیمت ${PricesScreen.categoryTitle}',
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(
                          width: 48.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //
              const SizedBox(height: 10.0),
              // Prices list
              BlocBuilder<PricesCubit, PricesState>(
                buildWhen: (previous, current) {
                  if (previous.pricesDataStatus == current.pricesDataStatus) {
                    return false;
                  }
                  return true;
                },
                builder: (context, state) {
                  // Loading
                  if (state.pricesDataStatus is PricesDataLoading) {
                    return RefreshProgressIndicator(
                      color: Colors.grey.shade800,
                    );
                  }
                  // Completed
                  if (state.pricesDataStatus is PricesDataCompleted) {
                    PricesDataCompleted pricesDataCompleted =
                        state.pricesDataStatus as PricesDataCompleted;
                    // models
                    List priceModels = pricesDataCompleted.modelResults;

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: RefreshIndicator(
                          color: Colors.grey.shade800,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: priceModels.length,
                            itemBuilder: (context, index) {
                              // percentIcon
                              var percentIcon =
                                  DecimalRounder.setPercentChangesIcon(
                                      priceModels[index].percentChange);

                              return PriceItem(
                                index: index,
                                priceModels: priceModels,
                                cardColor: cardColor,
                                labelTitle: PricesScreen.categoryTitle,
                                primaryColor: primaryColor,
                                textTheme: textTheme,
                                percentIcon: percentIcon,
                              );
                            },
                          ),
                          onRefresh: () async {
                            await Future.delayed(
                              const Duration(seconds: 1),
                            );

                            switch (PricesScreen.categoryTitle) {
                              case 'طلا':
                                BlocProvider.of<PricesCubit>(context)
                                    .refreshGoldDataEvent();
                                break;
                              case 'سکه':
                                BlocProvider.of<PricesCubit>(context)
                                    .refreshCoinDataEvent();
                                break;
                              case 'ارز مرجع':
                                BlocProvider.of<PricesCubit>(context)
                                    .refreshCurrencyDataEvent();
                                break;
                              case 'ارز دیجیتال':
                                BlocProvider.of<PricesCubit>(context)
                                    .refreshCryptoDataEvent();
                                break;
                              case 'نفت و انرژی':
                                BlocProvider.of<PricesCubit>(context)
                                    .refreshEnergyDataEvent();
                                break;
                              default:
                            }
                          },
                        ),
                      ),
                    );
                  }
                  // Error
                  if (state.pricesDataStatus is PricesDataCompleted) {
                    return const Text('Error');
                  }

                  return Container();
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
