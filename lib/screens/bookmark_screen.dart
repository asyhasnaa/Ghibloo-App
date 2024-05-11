import 'package:flutter/material.dart';
import 'package:ghibloo_app/models/films_model.dart';
import 'package:ghibloo_app/services/api_service.dart';
import 'package:ghibloo_app/services/utils.dart';
import 'package:ghibloo_app/widget/film_card_widget.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late Future<List<FilmModel>> _bookmarkedFilmsFuture;

  @override
  void initState() {
    super.initState();
    _bookmarkedFilmsFuture = _loadBookmarkedFilms();
  }

  Future<List<FilmModel>> _loadBookmarkedFilms() async {
    List<String> bookmarkedFilmIds = await FilmStorage.getBookmarks();
    List<FilmModel> bookmarkedFilms = [];
    for (String id in bookmarkedFilmIds) {
      // Fetch each bookmarked film by ID and add it to the list
      FilmModel film = await ApiService().getFilmById(id);
      bookmarkedFilms.add(film);
    }
    return bookmarkedFilms;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder<List<FilmModel>>(
          future: _bookmarkedFilmsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              if (snapshot.data!.isEmpty) {
                // Display a message when no bookmarks are available
                return Center(child: Text("No bookmarks available"));
              } else {
                // Display the list of bookmarked films using FilmCardWidget
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return FilmCardWidget(film: snapshot.data![index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 15,
                    );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
