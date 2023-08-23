// ignore_for_file: unused_element, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_online/common/bloc/change_index/change_index_cubit.dart';
import 'package:price_online/common/helper/decimal_rounder.dart';
import 'package:price_online/features/feature_prices/presentation/bloc/prices_cubit/prices_cubit.dart';
import 'package:price_online/features/feature_prices/presentation/widgets/lebel_button.dart';
import 'package:price_online/features/feature_prices/presentation/widgets/price_item.dart';
import 'package:price_online/main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String labelTitle = 'طلا';
  static bool isHomeScreen = true;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // change statusbar color
    MyApp.changeColor(Colors.transparent, Brightness.dark);
    // size divaces
    var width = MediaQuery.of(context).size.width;
    // theme
    var textTheme = Theme.of(context).textTheme;
    var primaryColor = Theme.of(context).primaryColor;
    var cardColor = Theme.of(context).cardColor;

    // Sliders
    List<String> sliderImages = [
      'assets/images/a1.png',
      'assets/images/a2.png',
      'assets/images/a3.png',
      'assets/images/a4.png',
    ];

    final PageController pageViewController = PageController(initialPage: 0);
    int currentSlide = 0;
    Timer? timer;

    @override
    void dispose() {
      super.dispose();

      if (timer != null) {
        timer.cancel();
      }
    }

    timer ??= Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        if (currentSlide < 4) {
          currentSlide++;
        } else {
          currentSlide = 0;
        }

        if (pageViewController.positions.isNotEmpty) {
          pageViewController.animateToPage(currentSlide,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn);
        }
      },
    );

    // // Categories
    // List<String> categoryImages = [
    //   'assets/images/gold.svg',
    //   'assets/images/coin.svg',
    //   'assets/images/money.svg',
    //   'assets/images/bitcoin.svg',
    // ];
    List<String> categoryTitles = ['طلا', 'سکه', 'ارز مرجع', 'ارز دیجیتال'];

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
          // call price api
          switch (HomeScreen.labelTitle) {
            case 'طلا':
              BlocProvider.of<PricesCubit>(context).callGoldDataEvent();
              break;
            case 'سکه':
              BlocProvider.of<PricesCubit>(context).callCoinDataEvent();
              break;
            case 'ارز مرجع':
              BlocProvider.of<PricesCubit>(context).callCurrencyDataEvent();
              break;
            case 'ارز دیجیتال':
              BlocProvider.of<PricesCubit>(context).callCryptoDataEvent();
              break;
            default:
          }

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
                          width: 45.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // sliders
              Column(
                children: [
                  SizedBox(
                    width: width,
                    height: 160,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: sliderImages.length,
                      controller: pageViewController,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // print(sliderImages[index]);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Image(
                                image: AssetImage(sliderImages[index]),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // page indicator
                  sliderImages.length > 1
                      ? SmoothPageIndicator(
                          controller: pageViewController,
                          count: sliderImages.length,
                          effect: ExpandingDotsEffect(
                            dotHeight: 8.0,
                            dotWidth: 8.0,
                            activeDotColor: primaryColor,
                            dotColor: Colors.grey.shade400,
                            spacing: 5.0,
                          ),
                        )
                      : Container(),
                ],
              ),
              //
              const SizedBox(height: 22.0),
              // // categories
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(right: 5.0),
              //         child: Text('بازار ها', style: textTheme.titleMedium),
              //       ),
              //       const SizedBox(height: 10.0),
              //       SizedBox(
              //         height: 120,
              //         child: GridView.builder(
              //           physics: const NeverScrollableScrollPhysics(),
              //           gridDelegate:
              //               const SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 4,
              //             crossAxisSpacing: 15.0,
              //           ),
              //           itemCount: 4,
              //           itemBuilder: (context, index) {
              //             return CategoryWidget(
              //               image: categoryImages[index],
              //               title: categoryTitles[index],
              //               textTheme: textTheme,
              //               cardColor: cardColor,
              //               primaryColor: primaryColor,
              //             );
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // //
              // const SizedBox(height: 5.0),

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
                          categoryTitles.length,
                          (index) => LebelButton(
                            primaryColor: primaryColor,
                            textTheme: textTheme,
                            state: state,
                            index: index,
                            title: categoryTitles[index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              //
              const SizedBox(height: 12.0),
              // Title List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('برترین ها', style: textTheme.titleMedium),
                    Row(
                      children: [
                        Text(
                          'مشاهده همه',
                          style: TextStyle(color: primaryColor, fontSize: 16.0),
                        ),
                        const SizedBox(width: 3.0),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14.0,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              // Top Prices List
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
                                labelTitle: HomeScreen.labelTitle,
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

                            switch (HomeScreen.labelTitle) {
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
