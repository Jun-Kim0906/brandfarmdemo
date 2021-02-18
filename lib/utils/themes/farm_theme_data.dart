// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmThemeData {
  static const _lightFillColor = Color(0xffffffff);
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  // static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
  themeData(lightColorScheme, _lightFocusColor);

  // static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme.apply(
          displayColor: Color(0xff343434), fontFamily: GoogleFonts
          .roboto()
          .fontFamily),
      // Matches manifest.json colors and background color.
      primaryColor: colorScheme.primary,
      appBarTheme: AppBarTheme(
        textTheme: _textTheme.apply(bodyColor: colorScheme.onPrimary),
        color: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        brightness: colorScheme.brightness,
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary,),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      accentColor: colorScheme.primary,
      focusColor: focusColor,
      buttonTheme: ButtonThemeData(
        disabledColor: Color(0x33000000),
      ),
      disabledColor: Colors.white,
      dividerColor: Color(0xffdbdbdb),
      dividerTheme: DividerThemeData(
        thickness: 1.0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorScheme.primary
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xff15b85b),
    primaryVariant: Color(0xff7ACE96),
    secondary: Color(0xFF37949B),
    secondaryVariant: Color(0xFF018786),
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    onBackground: Colors.white,
    error: Color(0xFFCD0F0F),
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF414141),
    brightness: Brightness.light,
  );

  // static const ColorScheme darkColorScheme = ColorScheme(
  //   primary: Color(0xFFFF8383),
  //   primaryVariant: Color(0xFF1CDEC9),
  //   secondary: Color(0xFF4D1F7C),
  //   secondaryVariant: Color(0xFF451B6F),
  //   background: Color(0xFF241E30),
  //   surface: Color(0xFF1F1929),
  //   onBackground: Color(0x0DFFFFFF), // White with 0.05 opacity
  //   error: _darkFillColor,
  //   onError: _darkFillColor,
  //   onPrimary: _darkFillColor,
  //   onSecondary: _darkFillColor,
  //   onSurface: _darkFillColor,
  //   brightness: Brightness.dark,
  // );

  // static const _light = FontWeight.w300;
  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _bold = FontWeight.w700;

  // static const _extraBold = FontWeight.w800;

  static final TextTheme _textTheme = TextTheme(
    headline1: TextStyle(
        fontFamily: 'AppleSDGothicNeo', fontWeight: _bold, fontSize: 52.0),
    headline2: TextStyle(
        fontFamily: 'AppleSDGothicNeo', fontWeight: _bold, fontSize: 45.0),
    headline3: TextStyle(
        fontFamily: 'AppleSDGothicNeo', fontWeight: _bold, fontSize: 24.0),
    headline4: TextStyle(
        fontFamily: 'AppleSDGothicNeo', fontWeight: _bold, fontSize: 20.0),
    headline5: TextStyle(
        fontFamily: 'AppleSDGothicNeo', fontWeight: _bold, fontSize: 18.0),
    headline6: TextStyle(
        fontFamily: 'AppleSDGothicNeo', fontWeight: _bold, fontSize: 16.0),
    subtitle1: TextStyle(
        fontFamily: 'AppleSDGothicNeo', fontWeight: _medium, fontSize: 20.0),
    subtitle2: TextStyle(
        fontFamily: 'AppleSDGothicNeo', fontWeight: _medium, fontSize: 14.0),
    bodyText1: TextStyle(
        fontFamily: 'AppleSDGothicNeo', fontWeight: _regular, fontSize: 16.0),
    bodyText2: TextStyle(
        fontFamily: 'AppleSDGothicNeo', fontWeight: _regular, fontSize: 14.0),
    caption: TextStyle(
        fontFamily: 'AppleSDGothicNeo', fontWeight: _bold, fontSize: 8.0),
    overline: TextStyle(
        fontFamily: 'AppleSDGothicNeo', fontWeight: _bold, fontSize: 13.0),
    button: TextStyle(
        fontFamily: 'AppleSDGothicNeo', fontWeight: _bold, fontSize: 14.0),
  );
}

extension CustomStyles on TextTheme {
  TextStyle get infoContainerTitleTextTheme => TextStyle(
    fontFamily: 'AppleSDGothicNeo',
    fontSize: 14.0,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  TextStyle get infoContainerBodyTextTheme => TextStyle(
    fontFamily: 'AppleSDGothicNeo',
    fontSize: 16,
    color: Color(0xFF219653),
    fontWeight: FontWeight.normal,
  );
}