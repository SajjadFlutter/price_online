import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_online/common/bloc/change_index/change_index_cubit.dart';
import 'package:price_online/features/feature_home/presentation/bloc/gold_cubit/gold_cubit.dart';
import 'package:price_online/features/feature_home/presentation/widgets/lebel_button.dart';
import 'package:price_online/features/feature_home/repository/gold_repository.dart';
import 'package:price_online/locator.dart';
import 'package:price_online/main.dart';

class PricesScreen extends StatelessWidget {
  const PricesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // change statusbar color
    MyApp.changeColor(Colors.transparent, Brightness.dark);

    // theme
    var textTheme = Theme.of(context).textTheme;
    var primaryColor = Theme.of(context).primaryColor;

    // label categories
    final lebelCategories = ['طلا', 'سکه', 'ارز مرجع', 'ارز دیجیتال'];

    return Scaffold(
      // drawer
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              color: primaryColor,
            ),
            ListTile(
              leading: const Icon(Icons.headset_mic_rounded),
              title: Text('پشتیبانی', style: textTheme.titleLarge),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title:
                  Text('ارسال برنامه به دوستان', style: textTheme.titleLarge),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.star_rounded, size: 27.0),
              title: Text('ارسال نظر', style: textTheme.titleLarge),
              onTap: () {},
            ),
          ],
        ),
      ),
      // body
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 5.0),
            // appbar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(
                      Icons.menu_rounded,
                      color: primaryColor,
                      size: 24.0,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
                // title appbar
                Text('قیمت آنلاین', style: textTheme.titleLarge),
                const SizedBox(
                  width: 65.0,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            // Lelel categories
            BlocBuilder<ChangeIndexCubit, int>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: List.generate(
                      lebelCategories.length,
                      (index) => LebelButton(
                        primaryColor: primaryColor,
                        textTheme: textTheme,
                        state: state,
                        index: index,
                        title: lebelCategories[index],
                      ),
                    ),
                  ),
                );
              },
            ),
            // prices list
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => GoldCubit(locator<GoldRepository>())),
              ],
              child: const Column(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}