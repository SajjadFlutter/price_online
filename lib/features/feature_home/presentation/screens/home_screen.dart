import 'package:flutter/material.dart';
import 'package:price_online/features/feature_home/presentation/screens/about_us_screen.dart';
import 'package:price_online/locator.dart';
import 'package:price_online/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/home_appbar.dart';
import '../widgets/home_categories.dart';
import '../widgets/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String labelTitle = 'طلا';
  static bool isHomeScreen = true;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // size divaces
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    // theme
    var textTheme = Theme.of(context).textTheme;
    var primaryColor = Theme.of(context).primaryColor;
    var secondaryHeaderColor = Theme.of(context).secondaryHeaderColor;
    var cardColor = Theme.of(context).cardColor;
    var shadowColor = Theme.of(context).shadowColor;
    // change statusbar color
    // Show state for dark mode or light mode
    var isDarkMode =
        locator<SharedPreferences>().getBool('isDarkMode') ?? false;

    if (isDarkMode) {
      MyApp.changeColor(
        Colors.transparent,
        Brightness.light,
        Theme.of(context).scaffoldBackgroundColor,
      );
    } else {
      MyApp.changeColor(
        Colors.transparent,
        Brightness.dark,
        Theme.of(context).scaffoldBackgroundColor,
      );
    }

    // Sliders
    List<String> sliderImages = [
      'assets/images/Bitpin.jpg',
    ];

    final PageController pageViewController = PageController(initialPage: 0);
    // int currentSlide = 0;
    // Timer? timer;

    // @override
    // void dispose() {
    //   super.dispose();

    //   if (timer != null) {
    //     timer.cancel();
    //   }
    // }

    // timer ??= Timer.periodic(
    //   const Duration(seconds: 4),
    //   (timer) {
    //     if (currentSlide < 3) {
    //       currentSlide++;
    //     } else {
    //       currentSlide = 0;
    //     }

    //     if (pageViewController.positions.isNotEmpty) {
    //       pageViewController.animateToPage(currentSlide,
    //           duration: const Duration(milliseconds: 400),
    //           curve: Curves.easeIn);
    //     }
    //   },
    // );

    // Categories
    List<String> categoryImages = [
      'assets/images/gold.svg',
      'assets/images/coin.svg',
      'assets/images/money.svg',
      'assets/images/bitcoin.svg',
      'assets/images/energy.svg',
      'assets/images/metals.svg',
    ];
    List<String> categoryTitles = [
      'طلا',
      'سکه',
      'ارز مرجع',
      'ارز دیجیتال',
      'نفت و انرژی',
      'فلزات گرانبها',
    ];

    return Scaffold(
      // drawer
      drawer: HomeDrawer(
        textTheme: textTheme,
        secondaryHeaderColor: secondaryHeaderColor,
        primaryColor: primaryColor,
      ),
      // body
      body: SafeArea(
        child: Column(
          children: [
            // appbar
            HomeAppBar(
              secondaryHeaderColor: secondaryHeaderColor,
              textTheme: textTheme,
            ),
            // sliders
            SizedBox(
              width: width,
              height: 150,
              child: Stack(
                children: [
                  PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: sliderImages.length,
                    controller: pageViewController,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse(
                              'https://bitpin.ir/signup/?ref=Ohk73uWx');
                          if (!await launchUrl(url)) {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(
                              image: AssetImage(sliderImages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // page indicator
                  if (sliderImages.length > 1)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: SmoothPageIndicator(
                          controller: pageViewController,
                          count: sliderImages.length,
                          effect: ExpandingDotsEffect(
                            dotHeight: 8.0,
                            dotWidth: 8.0,
                            activeDotColor: primaryColor,
                            dotColor: Colors.grey,
                            spacing: 5.0,
                          ),
                        ),
                      ),
                    )
                  else
                    Container(),
                ],
              ),
            ),
            //
            const SizedBox(height: 25.0),
            // categories
            HomeCategories(
              textTheme: textTheme,
              width: width,
              categoryImages: categoryImages,
              categoryTitles: categoryTitles,
              cardColor: cardColor,
              primaryColor: primaryColor,
            ),
            //
            // const SizedBox(height: 20.0),
            // About us
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsScreen(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                height: 70.0,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: 10.0,
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 15.0),
                    Text('درباره ما', style: textTheme.titleMedium),
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18.0,
                      color: secondaryHeaderColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}