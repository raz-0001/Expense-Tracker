import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses.dart';


var kColorScheme=ColorScheme.fromSeed(seedColor: const Color.fromARGB(218, 199, 104, 239));
var kDarkScheme=ColorScheme.fromSeed(seedColor: const Color.fromARGB(218, 183, 215, 24),
brightness: Brightness.dark);

void main() {
    runApp( MaterialApp(
    darkTheme: ThemeData().copyWith(useMaterial3: true,
    colorScheme: kDarkScheme,
    cardTheme: const CardTheme().copyWith(
      color: kDarkScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 14,vertical: 14),
    )
    ),

    theme: ThemeData().copyWith(useMaterial3: true,
    colorScheme: kColorScheme,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: kColorScheme.onPrimaryContainer,
      foregroundColor: kColorScheme.primaryContainer,
    ),
    cardTheme: const CardTheme().copyWith(
      color: kColorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 14,vertical: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
      backgroundColor: kColorScheme.primaryContainer,
    )
    ),
    textTheme: ThemeData().textTheme.copyWith(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color:kColorScheme.onSecondaryContainer,
        fontSize: 20
      )
    )
    ),
    themeMode: ThemeMode.system,//Default
    home:const Expenses()
  ),
  );
  
}
