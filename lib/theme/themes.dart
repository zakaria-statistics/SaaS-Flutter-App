import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static List<ThemeData> themes = [
    /*ThemeData(
      useMaterial3: true,
      //primaryColor: Colors.pink,
      */ /*colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.pinkAccent,
        brightness: Brightness.light,
        surface: Colors.yellow,
        primaryContainer: Colors.yellow,
        background: Colors.grey
      ),*/ /*
      colorScheme: lightColorScheme,
    ),*/

    // Material 2 Themes

    /* ThemeData(
      useMaterial3: true,
      primaryColor: const Color(0xFF009688),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF009688),
        // Replace with your desired base color
        brightness: Brightness.dark,
      ),
    ),
    ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.blue,
      // Consider using primaryColor for a more specific shade
      primaryColor: Colors.lightBlue[800],
      // Adjust the shade as needed
      //hintColor: Colors.lightGreenAccent[400],
      textTheme: const TextTheme(
        // Customize font family, size, weight, etc.
        displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
      appBarTheme: AppBarTheme(
        color: Colors.blue[900], // Adjust the color for the app bar
      ),
    ),
    ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.teal,
      primaryColor: Colors.teal[700],
      //hintColor: Colors.pinkAccent[200],
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 22.0, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 22.0, color: Colors.black),
      ),
    ),

    ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.orange,
      primaryColor: Colors.orange[600],
      //hintColor: Colors.deepPurpleAccent[400],
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w500),
      ),
    ),

    ThemeData(
      useMaterial3: true,
      // Use the colorScheme property for Material 3 theming
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF675CEA),
        primary: Colors.yellow, // Replace with your desired base color
        brightness: Brightness.light,
      ),
    ),*/

    //+++++++++++++++++++++++++++++++++++++++++++++++

    ThemeData(
      useMaterial3: false,
      //appBarTheme: const AppBarTheme(backgroundColor: Colors.teal),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: Colors.grey),
      primaryColor: Colors.grey,
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          primary: Colors.white,
          secondary: Colors.blueGrey),
      textTheme: TextTheme(
        bodySmall: TextStyle(
          fontSize: 18,
          color: Colors.black54,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: 24,
          color: Colors.black87,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        bodyLarge: TextStyle(
          fontSize: 38,
          color: Colors.black,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.bold
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.poppins().fontFamily
        ),
        contentTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 16.0,
          fontFamily: GoogleFonts.poppins().fontFamily
        ),
        actionsPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        iconColor: Colors.blueGrey,
        shadowColor: Colors.grey
      ),
    ),

    /*ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: Colors.blue),
      primaryColor: Colors.blue,
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          primary: Colors.white,
          secondary: Colors.blue),
      textTheme: const TextTheme(
        bodySmall: TextStyle(fontSize: 18, color: Colors.blueGrey),
        bodyMedium: TextStyle(
          fontSize: 28,
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          fontSize: 38,
          color: Colors.lightBlue,
        ),
      ),
    ),
    ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Colors.deepOrange),
      primaryColor: Colors.deepOrange,
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          primary: Colors.white,
          secondary: Colors.deepOrange),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
      textTheme:  TextTheme(
        bodySmall: TextStyle(fontSize: 18, color: Colors.red),
        bodyMedium: TextStyle(
          fontSize: 28,
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          fontSize: 38,
          color: Colors.red,
          fontFamily: GoogleFonts.roboto().fontFamily,
        ),
      ),
    ),*/
  ];
}




