import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String image;

  OnboardingModel(
      {required this.title, required this.description, required this.image});
}

class OnboardingItems {
  List<OnboardingModel> items = [
    OnboardingModel(
        title: "Welcome to Ghibloo",
        description:
            "Ghibloo is a platform that provides information about Studio Ghibli films. You can find information about the films, characters, and locations.",
        image: "assets/onboarding/onboarding_1.png"),
    OnboardingModel(
        title: "Bookmark",
        description:
            "You can bookmark your favorite films and characters to easily access them later.",
        image: "assets/onboarding/onboarding_2.png"),
    OnboardingModel(
        title: "Search",
        description:
            "You can search for films, characters, and locations to find the information you need.",
        image: "assets/onboarding/onboarding_3.png"),
  ];
}
