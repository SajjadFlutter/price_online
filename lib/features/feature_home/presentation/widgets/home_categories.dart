import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'category_widget.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
    required this.textTheme,
    required this.width,
    required this.categoryImages,
    required this.categoryTitles,
    required this.cardColor,
    required this.primaryColor,
  });

  final TextTheme textTheme;
  final double width;
  final List<String> categoryImages;
  final List<String> categoryTitles;
  final Color cardColor;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text('بازار ها', style: textTheme.titleMedium),
              ),
              const SizedBox(width: 5.0),
              // Date
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  (DateTime.now().weekday == 6
                          ? 'شنبه '
                          : DateTime.now().weekday == 7
                              ? 'یکشنبه '
                              : DateTime.now().weekday == 1
                                  ? 'دوشنبه '
                                  : DateTime.now().weekday == 2
                                      ? 'سه شنبه '
                                      : DateTime.now().weekday == 3
                                          ? 'چهارشبنه '
                                          : DateTime.now().weekday == 4
                                              ? 'پنجشنبه '
                                              : 'جمعه ') +
                      DateTime.now().toPersianDateStr(),
                  style: textTheme.labelMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          SizedBox(
            height: width * 2 / 3,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return CategoryWidget(
                  image: categoryImages[index],
                  title: categoryTitles[index],
                  textTheme: textTheme,
                  cardColor: cardColor,
                  primaryColor: primaryColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
