import 'package:flutter/material.dart';
import 'package:ghibloo_app/models/films_model.dart';
import 'package:ghibloo_app/services/api_service.dart';

class FilmProvider extends ChangeNotifier {
  ApiService apiService = ApiService();
  late List<FilmModel> _films;

  Future<void> fetchFilms() async {
    _films = await apiService.getFilms();
    notifyListeners();
  }

  List<FilmModel> get films => _films;
}
