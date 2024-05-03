import 'package:dio/dio.dart';
import 'package:ghibloo_app/models/films_model.dart';

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
}
