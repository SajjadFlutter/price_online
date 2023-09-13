import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:price_online/common/helper/decimal_rounder.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:price_online/features/feature_home/presentation/screens/home_screen.dart';
import 'package:price_online/features/feature_prices/presentation/bloc/prices_cubit/prices_cubit.dart';
import 'package:price_online/features/feature_prices/presentation/screens/prices_screen.dart';

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
    var shadowColor = Theme.of(context).shadowColor;

    return Container(
      margin: EdgeInsets.only(
        top: index == 0 ? 5.0 : 4.0,
        bottom: index == (priceModels.length - 1) ? 15.0 : 4.0,
      ),
      height: 75.0,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 15.0),
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
              child: PricesScreen.categoryTitle == 'ارز مرجع'
                  ? SvgPicture.network(
                      priceModels[index].imageUrl,
                      width: 20.0,
                      height: 20.0,
                      fit: BoxFit.cover,
                      placeholderBuilder: (BuildContext context) => SizedBox(
                        width: 30.0,
                        height: 30.0,
                        child: CircularProgressIndicator(
                          color: primaryColor,
                          strokeWidth: 3.0,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: CachedNetworkImage(
                        fadeInDuration: const Duration(milliseconds: 500),
                        width: 30.0,
                        height: 30.0,
                        imageUrl: priceModels[index].imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Padding(
                          padding: const EdgeInsets.all(3.0),
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
            // title and symbol and time update
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    PricesScreen.categoryTitle == 'ارز دیجیتال'
                        ? priceModels[index].title.length > 8
                            ? priceModels[index].title.substring(0, 8)
                            : priceModels[index].title
                        : priceModels[index].title,
                    style: textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        '${priceModels[index].timeUpdate}'.toPersianDigit(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      PricesScreen.categoryTitle == 'ارز دیجیتال'
                          ? Text(
                              ' |  ${priceModels[index].symbol}',
                              style: const TextStyle(color: Colors.grey),
                            )
                          : Container(),
                    ],
                  ),
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
                            PricesScreen.categoryTitle == 'ارز دیجیتال'
                                ? priceModels[index].price.length > 10
                                    ? '${priceModels[index].price.substring(0, 10)}'
                                        .toPersianDigit()
                                    : '${priceModels[index].price.substring(1)}'
                                        .toPersianDigit()
                                : '${priceModels[index].price}'
                                    .toPersianDigit(),
                            style: textTheme.labelLarge,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            PricesScreen.categoryTitle == 'ارز دیجیتال' ||
                                    PricesScreen.categoryTitle == 'نفت و انرژی'
                                ? 'دلار'
                                : 'ریال',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
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
                                      ? '${'${priceModels[index].percent.substring(1)}'.toPersianDigit()} -'
                                      : '- ${'${priceModels[index].percent.substring(0)}'.toPersianDigit()}%'
                                  : priceModels[index].percentChange == 'high'
                                      ? HomeScreen.labelTitle == 'ارز دیجیتال'
                                          ? '${'${priceModels[index].percent}'.toPersianDigit()} +'
                                          : '+ ${'${priceModels[index].percent}'.toPersianDigit()}%'
                                      : '${priceModels[index].percent}'
                                          .toPersianDigit(),
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
