import 'package:flutter/material.dart';
import 'package:ghibloo_app/utils/color.dart';
import 'package:ghibloo_app/models/film_model.dart';
import 'package:ghibloo_app/view/screen/films/detail_film_screen.dart';

class FilmCategories extends StatelessWidget {
  const FilmCategories({
    super.key,
    required Future<List<FilmModel>> filmsFuture,
  }) : _filmsFuture = filmsFuture;

  final Future<List<FilmModel>> _filmsFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FilmModel>>(
        future: _filmsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            List<FilmModel> films = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    films.length,
                    (index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailFilmScreen(
                                        filmId: films[index].id)));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 150,
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border:
                                            Border.all(color: grey, width: 2),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            films[index].image,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      films[index].title,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      films[index].originalTitle,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: grey),
                                      maxLines: 1,
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
              ),
            );
          }
        });
  }
}
