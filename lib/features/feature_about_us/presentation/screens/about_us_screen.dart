import 'package:flutter/material.dart';

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
        child: Column(
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
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child:  Column(
                children: [
                  const Text(
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 14.0),
                    'همانطور که از نام اپلیکیشن پیداست، این اپلیکیشن یعنی همان « قیمت آنلاین » صرفا برای نمایش قیمت ها به صورت آنلاین در بازار های طلا، سکه، ارز های مرجع، ارز های دیجیتال، نفت و انرژی و همچنین فلزات گرانبها طراحی شده است و تیم برنامه نویسی ما همواره در تلاش است تا بهترین کیفیت را در این مسیر برای شما کاربران عزیز ارائه دهد.',
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text('سلب مسئلیت',style: textTheme.titleMedium),
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
          ],
        ),
      ),
    );
  }
}
