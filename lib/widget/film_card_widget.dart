import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ghibloo_app/models/films_model.dart';
import 'package:ghibloo_app/screens/detail_film_screen.dart';

class FilmCardWidget extends StatelessWidget {
  const FilmCardWidget({
    super.key,
    required this.film,
  });

  final FilmModel film;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailFilmScreen(filmId: film.id)));
      },
      child: SizedBox(
        width: 170,
        child: Stack(
          children: [
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            film.image,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      film.title,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      film.originalTitle,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_outlined,
                          size: 14,
                          color: Colors.yellow,
                        ),
                        Text(
                          "${film.rtScore}/100",
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey),
                        ),
                        const Text(
                          "    ~   ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const Icon(
                          Icons.calendar_today_sharp,
                          size: 15,
                          color: Colors.yellow,
                        ),
                        Text(
                          film.releaseDate,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 1,
              right: 11,
              child: IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: const Size(40, 40)),
                iconSize: 20,
                icon: film.isSaved
                    ? const Icon(
                        Icons.bookmark,
                        color: Colors.red,
                      )
                    : Icon(Icons.bookmark_border_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}
