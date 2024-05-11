import 'package:flutter/material.dart';
import 'package:ghibloo_app/providers/bookmark.provider.dart';
import 'package:ghibloo_app/providers/detail_film_provider.dart';
import 'package:ghibloo_app/providers/film_provider.dart';
import 'package:ghibloo_app/screens/home_screen.dart';
import 'package:ghibloo_app/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FilmProvider()),
        ChangeNotifierProvider(create: (context) => DetailFilmProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
      ],
      child: MaterialApp(
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
          colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromARGB(255, 58, 117, 60))
              .copyWith(background: Colors.white),
          fontFamily: GoogleFonts.lato().fontFamily,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
