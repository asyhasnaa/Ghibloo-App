import 'package:shared_preferences/shared_preferences.dart';

class FilmStorage {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<void> saveBookmark(String id) async {
    final SharedPreferences prefs = await _prefs;
    List<String> bookmarks = prefs.getStringList('bookmarks') ?? [];
    if (!bookmarks.contains(id)) {
      bookmarks.add(id);
      await prefs.setStringList('bookmarks', bookmarks);
    }
  }

  static Future<void> removeBookmark(String id) async {
    final SharedPreferences prefs = await _prefs;
    List<String> bookmarks = prefs.getStringList('bookmarks') ?? [];
    bookmarks.remove(id);
    await prefs.setStringList('bookmarks', bookmarks);
  }

  static Future<List<String>> getBookmarks() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getStringList('bookmarks') ?? [];
  }
}
