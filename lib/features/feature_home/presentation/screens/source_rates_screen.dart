import 'package:flutter/material.dart';

import '../../../../common/widgets/adivery_widget.dart';

class SourceRatesScreen extends StatelessWidget {
  const SourceRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // theme
    var textTheme = Theme.of(context).textTheme;
    // var primaryColor = Theme.of(context).primaryColor;
    var secondaryHeaderColor = Theme.of(context).secondaryHeaderColor;
    var cardColor = Theme.of(context).cardColor;
    var shadowColor = Theme.of(context).shadowColor;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SourceRatesLayer(
              secondaryHeaderColor: secondaryHeaderColor,
              textTheme: textTheme,
              cardColor: cardColor,
              shadowColor: shadowColor,
            ),
            const AdiveryWidget(),
          ],
        ),
      ),
    );
  }
}

class SourceRatesLayer extends StatelessWidget {
  const SourceRatesLayer({
    super.key,
    required this.secondaryHeaderColor,
    required this.textTheme,
    required this.cardColor,
    required this.shadowColor,
  });

  final Color secondaryHeaderColor;
  final TextTheme textTheme;
  final Color cardColor;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
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
                    'منبع نرخ ها',
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
        const SizedBox(height: 5.0),
        // The text for about us section
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text('سایت های منبع :', style: textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 20.0),
              const Text(
                style: TextStyle(fontSize: 18.0),
                '/https://bazaretala.com',
              ),
              const SizedBox(height: 5.0),
              const Text(
                style: TextStyle(fontSize: 18.0),
                '/https://coinmarketcap.com',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
