import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:price_online/common/bloc/change_index/change_index_cubit.dart';
import 'package:price_online/config/my_theme.dart';
import 'package:price_online/features/feature_home/presentation/screens/prices_screen.dart';
import 'package:price_online/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init locator
  await initLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ChangeIndexCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
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
      home: const PricesScreen(),
    );
  }

  static void changeColor(Color statusBarColor, Brightness brightness) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: brightness,
      ),
    );
  }
}
