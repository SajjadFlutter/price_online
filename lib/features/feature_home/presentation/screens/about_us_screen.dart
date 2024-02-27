import 'package:flutter/material.dart';

import '../../../../common/widgets/adivery_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
            AboutUsLayer(
              secondaryHeaderColor: secondaryHeaderColor,
              textTheme: textTheme,
              cardColor: cardColor,
              shadowColor: shadowColor,
            ),
            const AdiveryWidget()
          ],
        ),
      ),
    );
  }
}

class AboutUsLayer extends StatelessWidget {
  const AboutUsLayer({
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
                    'درباره ما',
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
            children: [
              const Text(
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14.0),
                'همانطور که از نام اپلیکیشن پیداست، این اپلیکیشن یعنی همان « قیمت آنلاین » صرفا برای نمایش قیمت ها به صورت آنلاین در بازار های طلا، سکه، ارز های مرجع، ارز های دیجیتال، نفت و انرژی و همچنین فلزات گرانبها طراحی شده است و تیم برنامه نویسی ما همواره در تلاش است تا بهترین کیفیت را در این مسیر برای شما کاربران عزیز ارائه دهد.',
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Text('سلب مسئولیت', style: textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 10.0),
              const Text(
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14.0),
                'هدف قیمت آنلاین صرفا اطلاع رسانی و آگاه کردن کاربران از قیمت های روز بازار های مذکور می باشد و هیچ مسئولیتی در قبال سرمایه گذاری یا حتی ضرر و زیان شما عزیزان نخواهد داشت.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 30.0),
        // chart
        // SizedBox(
        //   width: 450.0,
        //   height: 400.0,
        //   child: LineChart(
        //     LineChartData(
        //       maxX: 8.0,
        //       maxY: 8.0,
        //       minX: 0.0,
        //       minY: 0.0,
        //       baselineX: 8,
        //       baselineY: 8,
        //       lineTouchData: LineTouchData(touchTooltipData: ),
        //       titlesData: FlTitlesData(
        //         topTitles: const AxisTitles(
        //           sideTitles: SideTitles(
        //             showTitles: false,
        //           ),
        //         ),
        //         rightTitles: const AxisTitles(
        //           sideTitles: SideTitles(
        //             showTitles: false,
        //           ),
        //         ),
        //         leftTitles: const AxisTitles(
        //           sideTitles: SideTitles(
        //             showTitles: false,
        //           ),
        //         ),
        //         bottomTitles: AxisTitles(
        //           sideTitles: SideTitles(
        //             interval: 1,
        //             showTitles: true,
        //             getTitlesWidget: (value, meta) {
        //               switch (value) {
        //                 case 1:
        //                   return Text('شنبه');
        //                 case 2:
        //                   return Text('یکشنبه');
        //                 case 3:
        //                   return Text('دوشنبه');
        //                 case 4:
        //                   return Text('سه شنبه');
        //                 case 5:
        //                   return Text('چهارشنبه');
        //                 case 6:
        //                   return Text('پنجشنبه');
        //                 case 7:
        //                   return Text('جمعه');
        //                 default:
        //                   return Text('');
        //               }
        //             },
        //           ),
        //         ),
        //       ),
        //       lineBarsData: [
        //         LineChartBarData(
        //           spots: [
        //             const FlSpot(0, 0),
        //             const FlSpot(2, 6),
        //             const FlSpot(4, 5),
        //             const FlSpot(6, 4),
        //             const FlSpot(7, 5),
        //           ],
        //           isCurved: true,
        //           color: Colors.amber,
        //         ),
        //         // LineChartBarData(),
        //       ],
        //     ),
        //     duration: const Duration(milliseconds: 150), // Optional
        //     curve: Curves.linear, // Optional
        //   ),
        // ),
        // SfCartesianChart(
        //   primaryXAxis: CategoryAxis(),
        //   title: ChartTitle(text: 'نمودار طلای 18 عیار'),
        //   legend: const Legend(isVisible: true),
        //   tooltipBehavior: TooltipBehavior(enable: true),
        //   enableMultiSelection: false,
        //   series: <ChartSeries>[
        //     LineSeries<GoldData, String>(
        //       dataSource: data,
        //       xValueMapper: (GoldData goldData, _) => goldData.dateDay,
        //       yValueMapper: (GoldData goldData, _) => goldData.price,
        //       enableTooltip: false,
        //       isVisibleInLegend: false,
        //       dataLabelSettings: DataLabelSettings(isVisible: true,textStyle: textTheme.labelMedium),
        //       color: Colors.amber,
        //     )
        //   ],
        // ),
      ],
    );
  }
}

class GoldData {
  final String dateDay;
  final double price;

  GoldData(this.dateDay, this.price);
}
