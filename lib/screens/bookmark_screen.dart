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
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _bookmarkedFilmsFuture = _apiService.getFilms();
    _loadBookmarkedFilms();
  }

  Future<void> _loadBookmarkedFilms() async {
    List<String> bookmarkedIds = await FilmStorage.getBookmarks();
    setState(() {
      _bookmarkedFilmsFuture = _apiService.getFilmById(bookmarkedIds as String)
          as Future<List<FilmModel>>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
      ),
      body: FutureBuilder<List<FilmModel>>(
        future: _bookmarkedFilmsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return ListView.builder(
              itemCount:
                  snapshot.data?.length ?? 0, // Tambahkan penanganan nilai null
              itemBuilder: (context, index) {
                return FilmCardWidget(film: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
