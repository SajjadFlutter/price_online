// ignore_for_file: unused_element, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_online/common/bloc/change_bool/change_bool_cubit.dart';
import 'package:price_online/features/feature_home/presentation/bloc/theme_cubit/theme_cubit.dart';
import 'package:price_online/features/feature_home/presentation/widgets/category_widget.dart';
import 'package:price_online/locator.dart';
import 'package:price_online/main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String labelTitle = 'طلا';
  static bool isHomeScreen = true;
  static bool isDarkMode = false;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // size divaces
    var width = MediaQuery.of(context).size.width;
    // theme
    var textTheme = Theme.of(context).textTheme;
    var primaryColor = Theme.of(context).primaryColor;
    var secondaryHeaderColor = Theme.of(context).secondaryHeaderColor;
    var cardColor = Theme.of(context).cardColor;
    var shadowColor = Theme.of(context).shadowColor;
    // change statusbar color
    MyApp.changeColor(Colors.transparent, Brightness.dark);

    // Sliders
    List<String> sliderImages = [
      'assets/images/a1.png',
      'assets/images/a2.png',
      'assets/images/a3.png',
      'assets/images/a4.png',
    ];

    final PageController pageViewController = PageController(initialPage: 0);
    int currentSlide = 0;
    Timer? timer;

    @override
    void dispose() {
      super.dispose();

      if (timer != null) {
        timer.cancel();
      }
    }

    timer ??= Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        if (currentSlide < 3) {
          currentSlide++;
        } else {
          currentSlide = 0;
        }

        if (pageViewController.positions.isNotEmpty) {
          pageViewController.animateToPage(currentSlide,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn);
        }
      },
    );

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
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              color: primaryColor,
            ),
            // Support
            ListTile(
              leading: Icon(
                Icons.headset_mic_rounded,
                color: secondaryHeaderColor,
              ),
              title: Text('پشتیبانی', style: textTheme.labelMedium),
              onTap: () async {
                final Uri url = Uri.parse('https://t.me/price_online_support');
                if (!await launchUrl(url)) {
                  throw 'Could not launch $url';
                }
                // await launchUrl(_url.toString());
              },
            ),
            // Share to another
            ListTile(
              leading: Icon(
                Icons.share,
                color: secondaryHeaderColor,
              ),
              title:
                  Text('ارسال برنامه به دوستان', style: textTheme.labelMedium),
              onTap: () {
                Share.share('package="com.example.price_online');
              },
            ),
            // Send idea
            ListTile(
              leading: Icon(
                Icons.star_rounded,
                size: 25.0,
                color: secondaryHeaderColor,
              ),
              title: Text('ارسال نظر', style: textTheme.labelMedium),
              onTap: () {},
            ),
            const Divider(),
            // Dark mode
            ListTile(
              leading: Icon(
                Icons.dark_mode_rounded,
                size: 25.0,
                color: secondaryHeaderColor,
              ),
              title: Text('حالت تیره', style: textTheme.labelMedium),
              trailing: BlocBuilder<ChangeBoolCubit, bool>(
                builder: (context, state) {
                  // Show state for dark mode or light mode
                  var isDarkMode =
                      locator<SharedPreferences>().getBool('isDarkMode') ??
                          false;

                  if (isDarkMode) {
                    state = true;
                  } else {
                    state = false;
                  }
                  return Switch.adaptive(
                    activeColor: primaryColor,
                    value: state,
                    onChanged: (state) {
                      HomeScreen.isDarkMode != HomeScreen.isDarkMode;
                      if (HomeScreen.isDarkMode == false) {
                        HomeScreen.isDarkMode = true;
                      } else {
                        HomeScreen.isDarkMode = false;
                      }
                      // Save state for dark mode or light mode
                      locator<SharedPreferences>().setBool('isDarkMode', state);

                      context.read<ChangeBoolCubit>().changeBool();
                      context.read<ThemeCubit>().toggleTheme();

                      if (state == true) {
                        setState(() {
                          MyApp.changeColor(
                              Colors.transparent, Brightness.light);
                        });
                      } else {
                        setState(() {
                          MyApp.changeColor(
                              Colors.transparent, Brightness.dark);
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
                          tooltip: MaterialLocalizations.of(context)
                              .openAppDrawerTooltip,
                        ),
                      ),
                      // title appbar
                      Text('قیمت آنلاین', style: textTheme.titleLarge),
                      const SizedBox(
                        width: 45.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // sliders
            Column(
              children: [
                SizedBox(
                  width: width,
                  height: 160,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: sliderImages.length,
                    controller: pageViewController,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // print(sliderImages[index]);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(
                              image: AssetImage(sliderImages[index]),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // page indicator
                sliderImages.length > 1
                    ? SmoothPageIndicator(
                        controller: pageViewController,
                        count: sliderImages.length,
                        effect: ExpandingDotsEffect(
                          dotHeight: 8.0,
                          dotWidth: 8.0,
                          activeDotColor: primaryColor,
                          dotColor: Colors.grey.shade400,
                          spacing: 5.0,
                        ),
                      )
                    : Container(),
              ],
            ),
            //
            const SizedBox(height: 10.0),
            // Container(
            //   child: Text(
            //       DateTime.now().weekday.toString() == '3' ? 'دوشنبه' : ''),
            // ),
            // SizedBox(
            //   height: 20.0,
            //   child: Marquee(
            //       text: 'ام', decelerationDuration: Duration(seconds: 2)),
            // ),
            // categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Text('بازار ها', style: textTheme.titleMedium),
                  ),
                  const SizedBox(height: 15.0),
                  SizedBox(
                    height: 300,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
            ),
            //
            const SizedBox(height: 20.0),
            // About us
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
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
