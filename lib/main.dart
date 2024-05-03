import 'package:flutter/material.dart';
import 'package:ghibloo_app/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ghibloo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)
            .copyWith(background: Colors.white),
        fontFamily: GoogleFonts.lato().fontFamily,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
