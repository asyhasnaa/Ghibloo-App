import 'package:flutter/material.dart';
import 'package:ghibloo_app/utils/color.dart';
import 'package:ghibloo_app/models/film_model.dart';
import 'package:ghibloo_app/providers/detail_film_provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class DetailFilmScreen extends StatelessWidget {
  final String filmId;
  const DetailFilmScreen({super.key, required this.filmId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailFilmProvider()..fetchFilmById(filmId),
      child: Consumer<DetailFilmProvider>(
        builder: (context, detailFilmProvider, child) {
          if (detailFilmProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (detailFilmProvider.error != null) {
            return Center(child: Text('Error: ${detailFilmProvider.error}'));
          } else if (detailFilmProvider.film == null) {
            return const Center(child: Text('Film not found'));
          } else {
            FilmModel film = detailFilmProvider.film!;
            return Scaffold(
              backgroundColor: kbackgroundColor,
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width - 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(film.movieBanner),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 10,
                          right: 10,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                style: IconButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(129, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  fixedSize: const Size(50, 50),
                                ),
                                icon: const Icon(Icons.arrow_back),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: MediaQuery.of(context).size.width - 120,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: kbackgroundColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            film.title.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: "serif",
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            film.originalTitle,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  const Icon(
                                    Iconsax.star5,
                                    size: 40,
                                    color: Colors.pink,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    film.rtScore,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Icon(
                                    Iconsax.clock4,
                                    size: 40,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    film.runningTime,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Icon(
                                    Iconsax.calendar5,
                                    size: 40,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    film.releaseDate,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "DESCRIPTION",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "serif",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            film.description,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: grey,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "DIRECTOR",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "serif",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            film.director,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: grey,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "PRODUCER",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "serif",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            film.producer,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: grey,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
