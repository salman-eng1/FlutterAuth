import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/shared/styles/colors.dart';
// ignore_for_file: prefer_const_constructors

ThemeData orangeTheme=ThemeData(
  fontFamily: 'Gotham-Black',
  primarySwatch: primarySwatch,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:  AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: primarySwatch,

    ),
    actionsIconTheme: IconThemeData(size: 50),
    titleTextStyle: TextStyle(
      color: logoColor,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(

    type: BottomNavigationBarType.fixed,
    selectedItemColor: primarySwatch,
    unselectedItemColor: Colors.grey.shade400,
    elevation: 20.0,
    backgroundColor: Colors.white,

  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primarySwatch,

  ),
  textTheme: TextTheme(bodyText1: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  )),
);
