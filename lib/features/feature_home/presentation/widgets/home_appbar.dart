import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.secondaryHeaderColor,
    required this.textTheme,
  });

  final Color secondaryHeaderColor;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu_rounded,
                    color: secondaryHeaderColor,
                    size: 24.0,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
              // title appbar
              Text('قیمت آنلاین', style: textTheme.titleLarge),
              const SizedBox(width: 45.0),
            ],
          ),
        ],
      ),
    );
  }
}
