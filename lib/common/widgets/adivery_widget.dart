import 'package:adivery/adivery.dart';
import 'package:adivery/adivery_ads.dart';
import 'package:flutter/material.dart';

class AdiveryWidget extends StatefulWidget {
  const AdiveryWidget({super.key});

  @override
  State<AdiveryWidget> createState() => _AdiveryWidgetState();
}

class _AdiveryWidgetState extends State<AdiveryWidget> {
  @override
  void initState() {
    super.initState();

    AdiveryPlugin.initialize('60276969-2cd1-42f0-af55-294faa13ddcb');
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: BannerAd(
                '727614a0-fea0-4eae-b278-fefa85a47e98',
                BannerAdSize.LARGE_BANNER,
                onAdLoaded: (ad) {},
                onAdClicked: (ad) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
