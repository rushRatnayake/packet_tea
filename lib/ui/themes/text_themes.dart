import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:packet_tea/ui/themes/appColors.dart';

/// https://api.flutter.dev/flutter/dart-ui/FontWeight-class.html
/// https://api.flutter.dev/flutter/material/TextTheme-class.html

///  NAME         SIZE  WEIGHT  SPACING             CASE
///  =======================================================
///  headline1    96.0  light   -1.5                Sentence
///  headline2    60.0  light   -0.5                Sentence
///  headline3    48.0  regular  0.0                Sentence
///  headline4    34.0  regular  0.25               Sentence
///  headline5    24.0  regular  0.0                Sentence
///  headline6    20.0  medium   0.15               Sentence
///  subtitle1    16.0  regular  0.15               Sentence
///  subtitle2    14.0  medium   0.1                Sentence
///  body1        16.0  regular  0.5   (bodyText1)  Sentence
///  body2        14.0  regular  0.25  (bodyText2)  Sentence
///  button       14.0  medium   1.25               All Caps
///  caption      12.0  regular  0.4                Sentence
///  overline     10.0  regular  1.5                All Caps

/// WEIGHT        VALUE
/// ===================================
/// Bold          w700
/// Normal        w400 (Regular, Plain)
/// Thin          w100
/// Extra-Light   w200
/// Light         w300
/// Medium        w500
/// Semi-Bold     w600
/// Extra-Bold    w800
/// Black         w900

final TextStyle headline1 = GoogleFonts.roboto(
  fontSize: 96.0,
  fontWeight: FontWeight.w300,
  letterSpacing: -1.5,
);

final TextStyle headline2 = GoogleFonts.roboto(
  fontSize: 60.0,
  fontWeight: FontWeight.w300,
  letterSpacing: -.5,
);

final TextStyle headline3 = GoogleFonts.roboto(
  fontSize: 48.0,
  fontWeight: FontWeight.normal,
  letterSpacing: 0,
);

final TextStyle headline4 = GoogleFonts.roboto(
  fontSize: 34.0,
  fontWeight: FontWeight.normal,
  letterSpacing: .25,
);

final TextStyle headline5 = GoogleFonts.roboto(
  fontSize: 24.0,
  fontWeight: FontWeight.normal,
);

final TextStyle headline6 = GoogleFonts.roboto(
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
  letterSpacing: .15,
);

final TextStyle subtitle1 = GoogleFonts.roboto(
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
  letterSpacing: .15,
);

final TextStyle subtitle2 = GoogleFonts.roboto(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  letterSpacing: .1,
);

final TextStyle bodyText1 = GoogleFonts.roboto(
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
  letterSpacing: .5,
);

final TextStyle bodyText2 = GoogleFonts.roboto(
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  letterSpacing: .25,
);

final TextStyle button = GoogleFonts.roboto(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 1.25,
);

final TextStyle caption = GoogleFonts.roboto(
  fontSize: 12.0,
  fontWeight: FontWeight.normal,
  letterSpacing: .4,
);

final TextStyle overline = GoogleFonts.roboto(
  fontSize: 10.0,
  fontWeight: FontWeight.normal,
  letterSpacing: 1.5,
);

/// Text theme for light mode
final TextTheme appThemeTextTheme = TextTheme(
  headline1: headline1.copyWith(color: AppColors.dimGrey),
  headline2: headline2.copyWith(color: AppColors.dimGrey),
  headline3: headline3.copyWith(color: AppColors.dimGrey),
  headline4: headline4.copyWith(color: AppColors.dimGrey),
  headline5: headline5.copyWith(color: AppColors.dimGrey),
  headline6: headline6.copyWith(color: AppColors.dimGrey),
  subtitle1: subtitle1.copyWith(color: AppColors.dimGrey),
  subtitle2: subtitle2.copyWith(color: AppColors.dimGrey),
  bodyText1: bodyText1.copyWith(color: AppColors.dimGrey),
  bodyText2: bodyText2.copyWith(color: AppColors.dimGrey),
  button: button.copyWith(color: AppColors.dimGrey),
  caption: caption.copyWith(color: AppColors.dimGrey),
  overline: overline.copyWith(color: AppColors.dimGrey),
);

final TextTheme appThemeBarTextThemes = TextTheme(
  headline1: headline1.copyWith(color: AppColors.appGreen1.withOpacity(0.8)),
  headline2: headline2.copyWith(color: AppColors.appGreen1.withOpacity(0.8)),
  headline3: headline3.copyWith(color: AppColors.appGreen1.withOpacity(0.8)),
  headline4: headline4.copyWith(color: AppColors.appGreen1.withOpacity(0.8)),
  headline5: headline5.copyWith(color: AppColors.appGreen1.withOpacity(0.8)),
  headline6: headline6.copyWith(color: AppColors.appGreen1.withOpacity(0.8)),
  subtitle1: subtitle1.copyWith(color: AppColors.appGreen1.withOpacity(0.8)),
  subtitle2: subtitle2.copyWith(color: AppColors.appGreen1.withOpacity(0.8)),
  bodyText1: bodyText1.copyWith(color: AppColors.appGreen1.withOpacity(0.8)),
  bodyText2: bodyText2.copyWith(color: AppColors.appGreen1.withOpacity(0.8)),
  button: button.copyWith(color: AppColors.appGreen1.withOpacity(0.8)),
  caption: caption.copyWith(color: AppColors.appGreen1.withOpacity(0.8)),
  overline: overline.copyWith(color: AppColors.appGreen1.withOpacity(0.8)),
);