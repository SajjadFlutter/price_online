// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:price_online/features/feature_prices/presentation/screens/prices_screen.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.image,
    required this.title,
    required this.textTheme,
    required this.cardColor,
    required this.primaryColor,
  });

  final String image;
  final String title;
  final TextTheme textTheme;
  final Color cardColor;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    var shadowColor = Theme.of(context).shadowColor;
    return GestureDetector(
      onTap: () {
        PricesScreen.categoryTitle = title;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PricesScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              width: 35.0,
              color: primaryColor,
            ),
            const SizedBox(height: 16.0),
            Text(
              title,
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
