import 'package:dio/dio.dart';
import 'package:ghibloo_app/models/character_model.dart';
import 'package:ghibloo_app/models/film_model.dart';
import 'package:ghibloo_app/utils/shared_pref.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl = "https://ghibliapi.vercel.app";

  Future<List<FilmModel>> getFilms() async {
    try {
      Response response = await _dio.get("$baseUrl/films");
      List<dynamic> data = response.data;
      List<FilmModel> films =
          data.map((json) => FilmModel.fromJson(json)).toList();
      return films;
    } catch (error) {
      throw Exception('Failed to load films: $error');
    }
  }

  Future<FilmModel> getFilmById(String id) async {
    try {
      Response response = await _dio.get("$baseUrl/films/$id");
      Map<String, dynamic> data = response.data;
      FilmModel film = FilmModel.fromJson(data);
      return film;
    } catch (error) {
      throw Exception('Failed to load film: $error');
    }
  }

  Future<List<FilmModel>> getBookmarkedFilms() async {
    List<String> bookmarkedIds = await FilmStorage.getBookmarks();
    List<FilmModel> allFilms = await getFilms();
    List<FilmModel> bookmarkedFilms =
        allFilms.where((film) => bookmarkedIds.contains(film.id)).toList();
    return bookmarkedFilms;
  }

  Future<List<CharacterModel>> getCharacter() async {
    try {
      Response response = await _dio.get("$baseUrl/people");
      List<dynamic> data = response.data;
      List<CharacterModel> people =
          data.map((json) => CharacterModel.fromJson(json)).toList();
      return people;
    } catch (error) {
      throw Exception('Failed to load films: $error');
    }
  }

  Future<CharacterModel> getCharacterById(String id) async {
    try {
      Response response = await _dio.get("$baseUrl/people/$id");
      return CharacterModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to load character: $error');
    }
  }

  Future<List<CharacterModel>> getCharactersByIds(List<String> ids) async {
    try {
      List<CharacterModel> characters = [];
      for (String id in ids) {
        Response response = await _dio.get("$baseUrl/people/$id");
        characters.add(CharacterModel.fromJson(response.data));
      }
      return characters;
    } catch (error) {
      throw Exception("Failed to load characters: $error");
    }
  }
}
