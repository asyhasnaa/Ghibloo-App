import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ghibloo_app/view/screen/onboarding/onboarding_screen.dart';
import 'package:ghibloo_app/view/widget/bottom_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      final prefs = await SharedPreferences.getInstance();
      final bool? onboardingCompleted = prefs.getBool('onboarding');

      if (onboardingCompleted == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/splash_image.jpg"),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset("assets/images/splash_logo.png",
                width: 300, height: 300),
          ),
        ),
      ),
    );
  }
}
