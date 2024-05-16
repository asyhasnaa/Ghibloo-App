import 'package:flutter/material.dart';
import 'package:ghibloo_app/utils/shared_pref.dart';

class BookmarkProvider extends ChangeNotifier {
  late List<String> _bookmarkedFilmIds = [];

  Future<void> fetchBookmarkedFilmIds() async {
    _bookmarkedFilmIds = await FilmStorage.getBookmarks();
    notifyListeners();
  }

  List<String> get bookmarkedFilmIds {
    if (_bookmarkedFilmIds.isEmpty) {
      fetchBookmarkedFilmIds();
    }
    return _bookmarkedFilmIds;
  }
}
