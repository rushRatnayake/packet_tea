import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appColors.dart';
import 'text_themes.dart';

final ThemeData AppThemeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.naturalLightGreen,
    secondaryHeaderColor: AppColors.grey.withOpacity(0.4),
    accentColor: AppColors.appGreen1,
    appBarTheme: AppBarTheme(
        color:Colors.white,
        iconTheme: IconThemeData(color: AppColors.appGreen1),
        textTheme: appThemeBarTextThemes,
        brightness: Brightness.light
    ),
    textTheme: appThemeTextTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.appGreen2,
      foregroundColor: AppColors.naturalLightGreen,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      // elevation: 50,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.appGreen1,
      unselectedItemColor: AppColors.appGreen1.withOpacity(0.5),
      selectedIconTheme: IconThemeData(color: AppColors.appGreen1),
      unselectedIconTheme: IconThemeData(color: AppColors.appGreen1.withOpacity(0.5)),
    ),
    cardColor: AppColors.white,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    sliderTheme: SliderThemeData(
      activeTickMarkColor: AppColors.appGreen1,
      activeTrackColor: AppColors.appLightGreen1,
    ),
    scaffoldBackgroundColor: AppColors.white,
    iconTheme: IconThemeData(color: AppColors.black),
    colorScheme: ColorScheme(
      primary: AppColors.appGreen1,
      primaryVariant: AppColors.white,
      secondary: AppColors.appGreen2,
      secondaryVariant: AppColors.white,
      surface: AppColors.lightGrey,
      background: AppColors.darkGrey,
      error: AppColors.orangeRedCrayola,
      onPrimary: AppColors.white,
      onSecondary: AppColors.black,
      onSurface: AppColors.black,
      onBackground: AppColors.black,
      onError: AppColors.white,
      brightness: Brightness.light,
    ),
    bottomAppBarColor: AppColors.white,
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppColors.white,
      elevation: 0,
    ),
    unselectedWidgetColor: AppColors.appGreen1
);

final InputDecoration _inputDeco = InputDecoration(
  focusColor: AppColors.dimGrey,
  prefixStyle: bodyText2.copyWith(color: AppColors.dimGrey),
  suffixStyle: bodyText2.copyWith(color: AppColors.dimGrey),
  helperStyle: bodyText2.copyWith(color: AppColors.dimGrey),
  hintStyle: bodyText2.copyWith(color: AppColors.dimGrey),
  labelStyle: bodyText1.copyWith(color: AppColors.dimGrey),
  errorStyle: bodyText2.copyWith(
    color: AppColors.red,
    fontWeight: FontWeight.bold,
  ),
  fillColor: AppColors.white.withOpacity(0.1),
  filled: true,
  // enabledBorder: OutlineInputBorder(
  //   borderSide: BorderSide(
  //     color: AppColors.dimGrey,
  //   ),
  // ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.dimGrey,
        style: BorderStyle.solid,

      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0))
  ),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.red,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0))
  ),
  disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.grey,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0))
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.dimGrey,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0))
  ),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.red,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0))

  ),
);

InputDecoration lightModeInputDecoration() {
  return _inputDeco;
}
