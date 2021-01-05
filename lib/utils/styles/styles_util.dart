import 'package:brandfarmdemo/utils/colors/colors_util.dart';
import 'package:flutter/material.dart';

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

ThemeData buildMaterialTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    // colorScheme: brandFarmColorScheme,
    textTheme: TextTheme(
      // headline1: ,
      // headline2: ,
      // headline3: ,
      // headline4: ,
      // headline5: ,
      // headline6: ,
      subtitle1: TextStyle(color: Colors.black), // for login input text
      // subtitle2: ,
      // bodyText1: ,
      // bodyText2: ,
      // button: ,
      // caption: ,
      // overline: ,
    ),
  );
}

// use as followed => style: Theme.of(context).textTheme.appBarTitle
extension CustomStyles on TextTheme {
  TextStyle get appBarTitle => TextStyle(fontSize: 20, color: Colors.lime[800]);
  TextStyle get gridTileText => const TextStyle(fontSize: 10, color: Colors.white);
}