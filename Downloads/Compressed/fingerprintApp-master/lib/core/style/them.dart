import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(
    primary: Color.fromARGB(255, 12, 106, 160),
    secondary: Color(0xFF2EB5E0),
  ),
  textTheme: TextTheme(
      button: GoogleFonts.cairo(),
      overline: GoogleFonts.cairo(
        fontSize: 10,
      ),
      bodyText1: GoogleFonts.cairo(fontSize: 15, fontWeight: FontWeight.bold),
      bodyText2: GoogleFonts.cairo(color: Colors.grey[700], fontSize: 12),
      headline5: GoogleFonts.cairo(),
      headline6: GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      subtitle1: GoogleFonts.cairo()),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        padding: const EdgeInsets.all(16.0)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    color: Colors.white,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 18.0),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Color(0xFF0C6980),
    indicatorSize: TabBarIndicatorSize.tab,
    unselectedLabelColor: Colors.grey,
    indicator: BoxDecoration(),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: const Color(0xFF0C6980),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 4,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xFF0C6980),
    enableFeedback: true,
    showUnselectedLabels: true,
    showSelectedLabels: true,
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
  ),
);
