import 'package:flutter/material.dart';
import 'package:ghibloo_app/utils/color.dart';
import 'package:ghibloo_app/models/film_model.dart';
import 'package:ghibloo_app/view/screen/characters/character_list_screen.dart';
import 'package:ghibloo_app/view/screen/films/film_list_screen.dart';
import 'package:ghibloo_app/services/api_service.dart';
import 'package:ghibloo_app/view/widget/app_bar_widget.dart';
import 'package:ghibloo_app/view/widget/categories_widget.dart';
import 'package:ghibloo_app/view/widget/characters_categories_widget.dart';
import 'package:ghibloo_app/view/widget/film_categories_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiService apiService = ApiService();
  late Future<List<FilmModel>> _filmsFuture;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    _filmsFuture = apiService.getFilms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          width: 100,
        ),
        backgroundColor: kbackgroundColor,
        actions: const [
          AppbarWidget(),
          SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "WELCOME TO \nGHIBLI WORLD!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Serif",
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 190,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/banner.jpg"),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "CATEGORIES",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Serif",
                  ),
                ),
                const SizedBox(height: 10),
                const CategoriesWidget(
                  characters: [],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "FILMS",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Serif",
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FilmListScreen(),
                        ),
                      ),
                      child: const Text("View all"),
                    ),
                  ],
                ),
                FilmCategories(filmsFuture: _filmsFuture),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "CHARACTERS",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Serif",
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CharacterListScreen(),
                        ),
                      ),
                      child: const Text("View all"),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CharactersCategories(
                  charactersFuture: apiService.getCharacter(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
