import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ghibloo_app/models/films_model.dart';
import 'package:ghibloo_app/screens/detail_film_screen.dart';
import 'package:ghibloo_app/services/utils.dart';

class FilmCardWidget extends StatefulWidget {
  const FilmCardWidget({
    super.key,
    required this.film,
  });

  final FilmModel film;

  @override
  State<FilmCardWidget> createState() => _FilmCardWidgetState();
}

class _FilmCardWidgetState extends State<FilmCardWidget> {
  late bool isSaved;

  @override
  void initState() {
    super.initState();
    isSaved = widget.film.isSaved;
  }

  void _toggleBookmark() async {
    setState(() {
      isSaved = !isSaved;
      widget.film.isSaved = isSaved;
    });
    if (isSaved) {
      await FilmStorage.saveBookmark(widget.film.id);
    } else {
      await FilmStorage.removeBookmark(widget.film.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailFilmScreen(filmId: widget.film.id),
          ),
        );
      },
      child: SizedBox(
        width: 100,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.film.movieBanner,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5, // Adjust this value as needed
              left: 5, // Adjust this value as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.film.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.film.originalTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 1,
              right: 11,
              child: IconButton(
                onPressed: _toggleBookmark,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  fixedSize: const Size(40, 40),
                ),
                iconSize: 20,
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: isSaved ? Colors.yellow : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
