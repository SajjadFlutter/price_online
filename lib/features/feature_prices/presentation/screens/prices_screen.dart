// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_online/common/bloc/change_index/change_index_cubit.dart';
import 'package:price_online/common/helper/decimal_rounder.dart';
import 'package:price_online/features/feature_prices/presentation/bloc/prices_cubit/prices_cubit.dart';
import 'package:price_online/features/feature_prices/presentation/widgets/lebel_button.dart';
import 'package:price_online/features/feature_prices/presentation/widgets/price_item.dart';
import 'package:price_online/main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PricesScreen extends StatelessWidget {
  const PricesScreen({super.key});

  static String labelTitle = 'طلا';
  // label categories
  static final labelCategories = [
    'طلا',
    'سکه',
    'ارز مرجع',
    'ارز دیجیتال',
  ];

  @override
  Widget build(BuildContext context) {
    // change statusbar color
    MyApp.changeColor(Colors.transparent, Brightness.dark);
    // theme
    var textTheme = Theme.of(context).textTheme;
    var primaryColor = Theme.of(context).primaryColor;
    var cardColor = Theme.of(context).cardColor;

    return Scaffold(
      // drawer
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              color: primaryColor,
            ),
            ListTile(
              leading: const Icon(Icons.headset_mic_rounded),
              title: Text('پشتیبانی', style: textTheme.titleMedium),
              onTap: () async {
                final Uri url = Uri.parse('https://t.me/price_online_support');
                if (!await launchUrl(url)) {
                  throw 'Could not launch $url';
                }
                // await launchUrl(_url.toString());
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title:
                  Text('ارسال برنامه به دوستان', style: textTheme.titleMedium),
              onTap: () {
                Share.share('package="com.example.price_online');
              },
            ),
            ListTile(
              leading: const Icon(Icons.star_rounded, size: 27.0),
              title: Text('ارسال نظر', style: textTheme.titleMedium),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Builder(builder: (context) {
          // call gold api
          BlocProvider.of<PricesCubit>(context).callGoldDataEvent();
          return Column(
            children: [
              // appbar
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder: (context) => IconButton(
                            icon: Icon(
                              Icons.menu_rounded,
                              color: Colors.grey.shade800,
                              size: 24.0,
                            ),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                            tooltip: MaterialLocalizations.of(context)
                                .openAppDrawerTooltip,
                          ),
                        ),
                        // title appbar
                        Text('قیمت آنلاین', style: textTheme.titleLarge),
                        const SizedBox(
                          width: 48.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //
              const SizedBox(height: 9.0),
              // Lelel categories
              BlocBuilder<ChangeIndexCubit, int>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          labelCategories.length,
                          (index) => LebelButton(
                            primaryColor: primaryColor,
                            textTheme: textTheme,
                            state: state,
                            index: index,
                            title: labelCategories[index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              //
              const SizedBox(height: 20.0),
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
                                labelTitle: labelTitle,
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

                            switch (PricesScreen.labelTitle) {
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
