import 'package:flutter/material.dart';
import 'package:ghibloo_app/services/utils.dart';

class BookmarkProvider extends ChangeNotifier {
  late List<String> _bookmarkedFilmIds = []; // Initialize with an empty list

  Future<void> fetchBookmarkedFilmIds() async {
    _bookmarkedFilmIds = await FilmStorage.getBookmarks();
    notifyListeners();
  }

  List<String> get bookmarkedFilmIds {
    // Ensure _bookmarkedFilmIds is initialized before accessing it
    if (_bookmarkedFilmIds.isEmpty) {
      fetchBookmarkedFilmIds(); // Call fetchBookmarkedFilmIds if _bookmarkedFilmIds is empty
    }
    return _bookmarkedFilmIds;
  }
}
