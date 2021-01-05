import 'package:flutter/material.dart';

ThemeData buildMaterialTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: brandFarmColorScheme,
    textTheme: _textTheme,
  );
}

// NAME         SIZE  WEIGHT  SPACING
// headline1    96.0  light   -1.5
// headline2    60.0  light   -0.5
// headline3    48.0  regular  0.0
// headline4    34.0  regular  0.25
// headline5    24.0  regular  0.0
// headline6    20.0  medium   0.15
// subtitle1    16.0  regular  0.15
// subtitle2    14.0  medium   0.1
// body1        16.0  regular  0.5   (bodyText1)
// body2        14.0  regular  0.25  (bodyText2)
// button       14.0  medium   1.25
// caption      12.0  regular  0.4
// overline     10.0  regular  1.5

TextTheme _textTheme = TextTheme(
  // headline1: ,
  // headline2: ,
  // headline3: ,
  // headline4: ,
  // headline5: ,
  // headline6: ,
  subtitle1: TextStyle(color: Colors.black),
  // subtitle2: ,
  // bodyText1: ,
  // bodyText2: ,
  // button: ,
  // caption: ,
  // overline: ,
);

// use as followed => style: Theme.of(context).textTheme.appBarTitle
extension CustomStyles on TextTheme {
  TextStyle get appBarTitle => TextStyle(fontSize: 20, color: Colors.lime[800]);
  TextStyle get gridTileText => const TextStyle(fontSize: 10, color: Colors.white);
}


// colors
const Color Teal400 = Color(0xFF26A69A);
const Color Blue50 = Color(0xFFE3F2FD);
const Color Pink50 = Color(0xFFFCE4EC);
const Color Pink100 = Color(0xFFF8BBD0);
const Color Pink300 = Color(0xFFF06292);
const Color Pink400 = Color(0xFFEC407A);
const Color Brown900 = Color(0xFF3E2723);
const Color Brown600 = Color(0xFF6D4C41);
const Color ErrorRed = Color(0xFFF44336);
const Color SurfaceWhite = Color(0xFFFFFFFF);
const Color BackgroundWhite = Color(0xFFFFFFFF);
const defaultLetterSpacing = 0.03;

const ColorScheme brandFarmColorScheme = ColorScheme(
  primary: Blue50,
  primaryVariant: Brown900,
  secondary: Blue50,
  secondaryVariant: Brown900,
  surface: SurfaceWhite,
  background: BackgroundWhite,
  error: ErrorRed,
  onPrimary: Brown900,
  onSecondary: Brown900,
  onSurface: Brown900,
  onBackground: Brown900,
  onError: SurfaceWhite,
  brightness: Brightness.light,
);