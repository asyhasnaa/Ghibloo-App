import 'package:flutter/material.dart';
import 'package:ghibloo_app/utils/color.dart';
import 'package:ghibloo_app/utils/icon.dart';
import 'package:ghibloo_app/models/character_model.dart';
import 'package:ghibloo_app/view/screen/characters/character_list_screen.dart';
import 'package:ghibloo_app/view/screen/films/film_list_screen.dart';

class CategoriesWidget extends StatelessWidget {
  final List<CharacterModel> characters;
  const CategoriesWidget({
    super.key,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        children: [
          ...categoriesIcons.map((icon) => GestureDetector(
                onTap: () {
                  if (icon.title == 'Films') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FilmListScreen()),
                    );
                  } else if (icon.title == "Characters") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CharacterListScreen()),
                    );
                  }
                },
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: icon.color,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Image.asset(
                        'assets/icons/${icon.icon}.png',
                      ),
                    ),
                    Text(
                      icon.title,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: grey),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
