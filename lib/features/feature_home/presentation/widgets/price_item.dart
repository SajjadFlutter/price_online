import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:price_online/common/helper/decimal_rounder.dart';
import 'package:price_online/features/feature_home/presentation/bloc/prices_cubit/prices_cubit.dart';
import 'package:price_online/features/feature_home/presentation/screens/home_screen.dart';

class PriceItem extends StatelessWidget {
  const PriceItem({
    super.key,
    required this.index,
    required this.priceModels,
    required this.cardColor,
    required this.labelTitle,
    required this.primaryColor,
    required this.textTheme,
    required this.percentIcon,
  });

  final int index;
  final List priceModels;
  final Color cardColor;
  final String labelTitle;
  final Color primaryColor;
  final TextTheme textTheme;
  final Widget percentIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: index == 0 ? 5.0 : 4.0,
        bottom: index == (priceModels.length - 1) ? 15.0 : 4.0,
      ),
      height: 70.0,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 5, left: 15.0),
        child: Row(
          children: [
            // HomeScreen.labelTitle == 'ارز دیجیتال'
            //     ? Text(
            //         '${index + 1}',
            //         style: textTheme.titleSmall,
            //       )
            //     : const SizedBox(),
            // image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: HomeScreen.labelTitle == 'ارز مرجع'
                  ? SvgPicture.network(
                      priceModels[index].imageUrl,
                      width: 25.0,
                      height: 25.0,
                      fit: BoxFit.cover,
                      placeholderBuilder: (BuildContext context) =>
                          CircularProgressIndicator(
                        color: primaryColor,
                        strokeWidth: 3.0,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: CachedNetworkImage(
                        fadeInDuration: const Duration(milliseconds: 500),
                        width: HomeScreen.labelTitle == 'طلا' ? 45.0 : 35.0,
                        height: 35.0,
                        imageUrl: priceModels[index].imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CircularProgressIndicator(
                            color: primaryColor,
                            strokeWidth: 3.0,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
            ),
            // title and time update
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    HomeScreen.labelTitle == 'ارز دیجیتال'
                        ? priceModels[index].title.length > 8
                            ? priceModels[index].title.substring(0, 8)
                            : priceModels[index].title
                        : priceModels[index].title,
                    style: textTheme.labelLarge,
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    priceModels[index].timeUpdate,
                    style: textTheme.labelSmall,
                  ),
                  // Text(
                  //   cryptoList[index]
                  //       .symbol
                  //       .toString(),
                  //   style: textTheme.labelSmall,
                  // ),
                ],
              ),
            ),
            // price and percent
            Flexible(
              fit: FlexFit.tight,
              child: BlocBuilder<PricesCubit, PricesState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            HomeScreen.labelTitle == 'ارز دیجیتال'
                                ? priceModels[index].price.length > 10
                                    ? priceModels[index].price.substring(0, 10)
                                    : priceModels[index].price.substring(1)
                                : priceModels[index].price,
                            style: textTheme.labelLarge,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            HomeScreen.labelTitle == 'ارز دیجیتال'
                                ? 'دلار'
                                : 'ریال',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          percentIcon,
                          Directionality(
                            textDirection:
                                HomeScreen.labelTitle != 'ارز دیجیتال'
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                            child: Text(
                              priceModels[index].percentChange == 'low'
                                  ? HomeScreen.labelTitle == 'ارز دیجیتال'
                                      ? '${priceModels[index].percent.substring(1)} -'
                                      : '- ${priceModels[index].percent.substring(0)}'
                                  : priceModels[index].percentChange == 'high'
                                      ? HomeScreen.labelTitle == 'ارز دیجیتال'
                                          ? '${priceModels[index].percent} +'
                                          : '+ ${priceModels[index].percent}'
                                      : priceModels[index].percent,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: DecimalRounder.setPercentChangesColor(
                                    priceModels[index].percentChange),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
