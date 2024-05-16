import 'package:flutter/material.dart';
import 'package:ghibloo_app/models/film_model.dart';
import 'package:ghibloo_app/services/api_service.dart';

class DetailFilmProvider extends ChangeNotifier {
  ApiService apiService = ApiService();
  FilmModel? _film;
  bool _isLoading = false;
  String? _error;

  FilmModel? get film => _film;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchFilmById(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _film = await apiService.getFilmById(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
