// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10.0,
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
          const SizedBox(height: 15.0),
          Text(
            title,
            style: textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
