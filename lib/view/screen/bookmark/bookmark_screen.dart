import 'package:flutter/material.dart';
import 'package:ghibloo_app/utils/color.dart';
import 'package:ghibloo_app/models/film_model.dart';
import 'package:ghibloo_app/services/api_service.dart';
import 'package:ghibloo_app/utils/shared_pref.dart';
import 'package:ghibloo_app/view/widget/app_bar_widget.dart';
import 'package:ghibloo_app/view/widget/film_card_widget.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

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
      FilmModel film = await ApiService().getFilmById(id);
      bookmarkedFilms.add(film);
    }
    return bookmarkedFilms;
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
        actions: const [AppbarWidget(), SizedBox(width: 20)],
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
                return const Center(
                    child: Text(
                  "No bookmarks available",
                  style: TextStyle(fontSize: 17),
                ));
              } else {
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
