import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:price_online/config/my_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(MyTheme.lightTheme);

  void toggleTheme() {
    if (state == MyTheme.lightTheme) {
      emit(MyTheme.darkTheme);
    } else {
      emit(MyTheme.lightTheme);
    }
  }
}
