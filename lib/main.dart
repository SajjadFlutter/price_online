import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:price_online/common/bloc/change_bool/change_bool_cubit.dart';
import 'package:price_online/common/bloc/change_index/change_index_cubit.dart';
import 'package:price_online/config/my_theme.dart';
import 'package:price_online/features/feature_home/presentation/bloc/theme_cubit/theme_cubit.dart';
import 'package:price_online/features/feature_intro/presentation/bloc/splash_cubit/splash_cubit.dart';
import 'package:price_online/features/feature_intro/presentation/screens/splash_screen.dart';
import 'package:price_online/features/feature_prices/presentation/bloc/prices_cubit/prices_cubit.dart';
import 'package:price_online/features/feature_prices/repository/prices_repository.dart';
import 'package:price_online/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init locator
  await initLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashCubit()),
        BlocProvider(create: (_) => ChangeIndexCubit()),
        BlocProvider(create: (_) => PricesCubit(locator<PricesRepository>())),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => ChangeBoolCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, state) {
        // Show state for dark mode or light mode
        var isDarkMode =
            locator<SharedPreferences>().getBool('isDarkMode') ?? false;

        if (isDarkMode) {
          state = MyTheme.darkTheme;
        } else {
          state = MyTheme.lightTheme;
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: state,
          darkTheme: MyTheme.darkTheme,
          // برای راستچین کردن اپلیکیشن
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale('fa', ''),
          supportedLocales: const [
            Locale('en'), // English
            Locale('fa'), // persian(farsi)
          ],
          title: 'قیمت آنلاین',
          home: const SplashScreen(),
        );
      },
    );
  }

  static void changeColor(
    Color statusBarColor,
    Brightness brightness,
    Color systemNavigationBarColor,
  ) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: brightness,
        systemNavigationBarColor: systemNavigationBarColor,
        systemNavigationBarIconBrightness: brightness,
      ),
    );
  }
}
