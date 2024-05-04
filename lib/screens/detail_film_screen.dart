import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ghibloo_app/models/films_model.dart';
import 'package:ghibloo_app/services/api_service.dart';

class DetailFilmScreen extends StatelessWidget {
  final String filmId;
  final ApiService apiService = ApiService();
  DetailFilmScreen({super.key, required this.filmId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FilmModel>(
        future: apiService.getFilmById(filmId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            FilmModel films = snapshot.data!;
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text(films.title),
                ),
                body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Positioned(
                              child: Container(
                                height: MediaQuery.of(context).size.width - 20,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: NetworkImage(films.image),
                                  fit: BoxFit.fill,
                                )),
                              ),
                            ),
                          ],
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
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  fixedSize: const Size(50, 50),
                                ),
                                icon: const Icon(Icons.arrow_back_ios),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            top: MediaQuery.of(context).size.width - 50,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                            ))
                      ],
                    )));
          }
        });
  }
}
