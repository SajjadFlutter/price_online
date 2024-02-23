import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/bloc/change_bool/change_bool_cubit.dart';
import '../../../../locator.dart';
import '../bloc/theme_cubit/theme_cubit.dart';
import '../screens/source_rates_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.textTheme,
    required this.secondaryHeaderColor,
    required this.primaryColor,
  });

  final TextTheme textTheme;
  final Color secondaryHeaderColor;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 240.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 40),
                SvgPicture.asset(
                  'assets/images/app_icon.svg',
                  width: 120.0,
                ),
                Text('نسخه : 1.0.3'.toPersianDigit(),
                    style: textTheme.labelMedium),
              ],
            ),
          ),
          const SizedBox(height: 5.0),
          const Divider(thickness: 1.5, height: 30.0),
          // Support (Telegram)
          ListTile(
            leading: Icon(
              Icons.headset_mic_rounded,
              color: secondaryHeaderColor,
            ),
            title: Text('پشتیبانی (تلگرام)', style: textTheme.labelMedium),
            onTap: () async {
              final Uri url = Uri.parse('https://t.me/application_support_1');
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                throw 'Could not launch $url';
              }
            },
          ),
          // Support (Eitaa)
          ListTile(
            leading: Icon(
              Icons.headset_mic_rounded,
              color: secondaryHeaderColor,
            ),
            title: Text('پشتیبانی (ایتا)', style: textTheme.labelMedium),
            onTap: () async {
              final Uri url =
                  Uri.parse('https://eitaa.com/application_support_1');
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                throw 'Could not launch $url';
              }
            },
          ),
          // Share to another
          ListTile(
            leading: Icon(
              Icons.share,
              color: secondaryHeaderColor,
            ),
            title: Text('ارسال برنامه به دوستان', style: textTheme.labelMedium),
            onTap: () {
              Share.share('https://myket.ir/app/com.example.price_online');
            },
          ),
          //
          const Divider(thickness: 1.5, height: 30.0),
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
                    locator<SharedPreferences>().getBool('isDarkMode') ?? false;

                if (isDarkMode) {
                  state = true;
                } else {
                  state = false;
                }
                return Switch.adaptive(
                  activeColor: primaryColor,
                  value: state,
                  onChanged: (state) {
                    // Save state for dark mode or light mode
                    locator<SharedPreferences>().setBool('isDarkMode', state);

                    context.read<ChangeBoolCubit>().changeBool();
                    context.read<ThemeCubit>().toggleTheme();
                  },
                );
              },
            ),
          ),
          //
          const Divider(thickness: 1.5, height: 30.0),
          // Source rate
          ListTile(
            leading: Icon(
              Icons.info_rounded,
              color: secondaryHeaderColor,
            ),
            title: Text('منبع نرخ ها', style: textTheme.labelMedium),
            onTap: () {
              var route = MaterialPageRoute(
                  builder: (context) => const SourceRatesScreen());
              Navigator.push(context, route);
            },
          ),
        ],
      ),
    );
  }
}