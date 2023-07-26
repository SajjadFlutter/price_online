import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:price_online/common/bloc/change_index/change_index_cubit.dart';
import 'package:price_online/features/feature_home/presentation/bloc/prices_cubit/prices_cubit.dart';
import 'package:price_online/features/feature_home/presentation/widgets/lebel_button.dart';
import 'package:price_online/features/feature_home/presentation/widgets/shimmer_item.dart';
import 'package:price_online/main.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String labelTitle = 'طلا';

  @override
  Widget build(BuildContext context) {
    // change statusbar color
    MyApp.changeColor(Colors.transparent, Brightness.dark);

    // theme
    var textTheme = Theme.of(context).textTheme;
    var primaryColor = Theme.of(context).primaryColor;

    // label categories
    final labelCategories = ['طلا', 'سکه', 'ارز مرجع', 'ارز دیجیتال'];

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
              title: Text('پشتیبانی', style: textTheme.titleLarge),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title:
                  Text('ارسال برنامه به دوستان', style: textTheme.titleLarge),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.star_rounded, size: 27.0),
              title: Text('ارسال نظر', style: textTheme.titleLarge),
              onTap: () {},
            ),
          ],
        ),
      ),
      // body
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 5.0),
              // appbar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(
                        Icons.menu_rounded,
                        color: primaryColor,
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
                    width: 65.0,
                  ),
                ],
              ),

              const SizedBox(height: 10.0),

              Builder(builder: (context) {
                // call api
                BlocProvider.of<PricesCubit>(context).callGoldDataEvent();
                return Column(
                  children: [
                    // Lelel categories
                    BlocBuilder<ChangeIndexCubit, int>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
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
                        );
                      },
                    ),
                    // prices list
                    BlocBuilder<PricesCubit, PricesState>(
                      buildWhen: (previous, current) {
                        if (previous.pricesDataStatus ==
                            current.pricesDataStatus) {
                          return false;
                        }
                        return true;
                      },
                      builder: (context, state) {
                        // Loading
                        if (state.pricesDataStatus is PricesDataLoading) {
                          return Column(
                            children: List.generate(
                              HomeScreen.labelTitle == 'طلا'
                                  ? 3
                                  : HomeScreen.labelTitle == 'سکه'
                                      ? 5
                                      : 10,
                              (index) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade400,
                                highlightColor: Colors.grey.shade200,
                                child: const ShimmerItem(),
                              ),
                            ),
                          );
                        }
                        // Completed
                        if (state.pricesDataStatus is PricesDataCompleted) {
                          PricesDataCompleted pricesDataCompleted =
                              state.pricesDataStatus as PricesDataCompleted;
                          // models
                          List priceModels = pricesDataCompleted.modelResults;

                          return Column(
                            children: List.generate(
                              priceModels.length,
                              (index) {
                                return SizedBox(
                                  height: 70.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5, left: 15.0),
                                    child: Row(
                                      children: [
                                        HomeScreen.labelTitle == 'ارز دیجیتال'
                                            ? Text(
                                                '${index + 1}',
                                                style: textTheme.titleSmall,
                                              )
                                            : const SizedBox(),
                                        // image
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(30.0),
                                            child: HomeScreen.labelTitle ==
                                                    'ارز مرجع'
                                                ? SvgPicture.network(
                                                    priceModels[index].imageUrl,
                                                    width: 35.0,
                                                    height: 35.0,
                                                    fit: BoxFit.cover,
                                                    placeholderBuilder:
                                                        (BuildContext context) =>
                                                            Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: primaryColor,
                                                        strokeWidth: 3.0,
                                                      ),
                                                    ),
                                                  )
                                                : CachedNetworkImage(
                                                    fadeInDuration:
                                                        const Duration(
                                                            milliseconds: 500),
                                                    width: 35.0,
                                                    height: 35.0,
                                                    imageUrl: priceModels[index]
                                                        .imageUrl,
                                                    fit: BoxFit.cover,
                                                    placeholder: (context, url) =>
                                                        Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: primaryColor,
                                                        strokeWidth: 3.0,
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(
                                                      Icons.error,
                                                      color: Colors.grey.shade700,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        // title
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                HomeScreen.labelTitle ==
                                                        'ارز دیجیتال'
                                                    ? priceModels[index]
                                                                .title
                                                                .length >
                                                            8
                                                        ? priceModels[index]
                                                            .title
                                                            .substring(0, 8)
                                                        : priceModels[index]
                                                            .title
                                                    : priceModels[index].title,
                                                style: textTheme.labelLarge,
                                              ),
                                              // const SizedBox(height: 4.0),
                                              // Text(
                                              //   cryptoList[index]
                                              //       .symbol
                                              //       .toString(),
                                              //   style: textTheme.labelSmall,
                                              // ),
                                            ],
                                          ),
                                        ),
                                        // price
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                priceModels[index].price,
                                                style: textTheme.labelLarge,
                                              ),
                                              const SizedBox(height: 4.0),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  // percentIcon,
                                                  Text(
                                                    priceModels[index].percent,
                                                    // style: TextStyle(
                                                    //   color: percentColor,
                                                    // ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        // Error
                        if (state.pricesDataStatus is PricesDataError) {
                          return const Text('error');
                        }
                        return Container();
                      },
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
