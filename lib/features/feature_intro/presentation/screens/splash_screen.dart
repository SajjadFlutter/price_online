import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/widgets/small_btn.dart';
import '../../../../locator.dart';
import '../../../../main.dart';
import '../../../feature_home/presentation/screens/home_screen.dart';
import '../bloc/splash_cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<SplashCubit>(context).checkConnectionEvent();
  }

  @override
  Widget build(BuildContext context) {
    // get divice size
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;

    // theme
    var primaryColor = Theme.of(context).primaryColor;
    // var secondaryHeaderColor = Theme.of(context).secondaryHeaderColor;
    // var cardColor = Theme.of(context).cardColor;
    var textTheme = Theme.of(context).textTheme;

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

    return Scaffold(
      body: Container(
        width: width,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/app_icon.svg',
                  width: 135.0,
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('قیمت آنلاین', style: textTheme.titleLarge),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 30.0,
              left: 0.0,
              right: 0.0,
              child: Column(
                children: [
                  BlocConsumer<SplashCubit, SplashState>(
                    listener: (context, state) {
                      if (state.connectionStatus is ConnectionOn) {
                        goToHome();
                      }
                    },
                    builder: (context, state) {
                      if (state.connectionStatus is ConnectionInitial ||
                          state.connectionStatus is ConnectionOn) {
                        return CircularProgressIndicator(color: primaryColor);
                      }

                      if (state.connectionStatus is ConnectionOff) {
                        return Column(
                          children: [
                            const Text(
                              'اتصال خود به اینترنت را چک کنید!',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.redAccent),
                            ),
                            const SizedBox(height: 12.0),
                            SmallBtn(
                              onPressed: () {
                                BlocProvider.of<SplashCubit>(context)
                                    .checkConnectionEvent();
                              },
                              child: const SizedBox(
                                width: 100.0,
                                child: Row(
                                  children: [
                                    SizedBox(width: 11.0),
                                    Text(
                                      'تلاش مجدد',
                                      style: TextStyle(
                                        fontFamily: 'shabnam',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    SizedBox(width: 5.0),
                                    Icon(
                                      Icons.replay,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> goToHome() async {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );
      },
    );
  }
}
