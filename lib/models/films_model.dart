import 'dart:convert';

import 'package:flutter/material.dart';

class FilmModel {
  String id;
  String title;
  String originalTitle;
  String originalTitleRomanised;
  String image;
  String movieBanner;
  String description;
  String director;
  String producer;
  String releaseDate;
  String runningTime;
  String rtScore;
  List<String> people;
  List<String> species;
  List<String> locations;
  List<String> vehicles;
  String url;

  FilmModel({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.originalTitleRomanised,
    required this.image,
    required this.movieBanner,
    required this.description,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.runningTime,
    required this.rtScore,
    required this.people,
    required this.species,
    required this.locations,
    required this.vehicles,
    required this.url,
  });

  FilmModel copyWith({
    String? id,
    String? title,
    String? originalTitle,
    String? originalTitleRomanised,
    String? image,
    String? movieBanner,
    String? description,
    String? director,
    String? producer,
    String? releaseDate,
    String? runningTime,
    String? rtScore,
    List<String>? people,
    List<String>? species,
    List<String>? locations,
    List<String>? vehicles,
    String? url,
  }) =>
      FilmModel(
        id: id ?? this.id,
        title: title ?? this.title,
        originalTitle: originalTitle ?? this.originalTitle,
        originalTitleRomanised:
            originalTitleRomanised ?? this.originalTitleRomanised,
        image: image ?? this.image,
        movieBanner: movieBanner ?? this.movieBanner,
        description: description ?? this.description,
        director: director ?? this.director,
        producer: producer ?? this.producer,
        releaseDate: releaseDate ?? this.releaseDate,
        runningTime: runningTime ?? this.runningTime,
        rtScore: rtScore ?? this.rtScore,
        people: people ?? this.people,
        species: species ?? this.species,
        locations: locations ?? this.locations,
        vehicles: vehicles ?? this.vehicles,
        url: url ?? this.url,
      );

  factory FilmModel.fromRawJson(String str) =>
      FilmModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FilmModel.fromJson(Map<String, dynamic> json) => FilmModel(
        id: json["id"],
        title: json["title"],
        originalTitle: json["original_title"],
        originalTitleRomanised: json["original_title_romanised"],
        image: json["image"],
        movieBanner: json["movie_banner"],
        description: json["description"],
        director: json["director"],
        producer: json["producer"],
        releaseDate: json["release_date"],
        runningTime: json["running_time"],
        rtScore: json["rt_score"],
        people: List<String>.from(json["people"].map((x) => x)),
        species: List<String>.from(json["species"].map((x) => x)),
        locations: List<String>.from(json["locations"].map((x) => x)),
        vehicles: List<String>.from(json["vehicles"].map((x) => x)),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "original_title": originalTitle,
        "original_title_romanised": originalTitleRomanised,
        "image": image,
        "movie_banner": movieBanner,
        "description": description,
        "director": director,
        "producer": producer,
        "release_date": releaseDate,
        "running_time": runningTime,
        "rt_score": rtScore,
        "people": List<dynamic>.from(people.map((x) => x)),
        "species": List<dynamic>.from(species.map((x) => x)),
        "locations": List<dynamic>.from(locations.map((x) => x)),
        "vehicles": List<dynamic>.from(vehicles.map((x) => x)),
        "url": url,
      };
  static getPosterImage(String title, double scale) {
    String _title = title.toLowerCase() + "_poster.jpg";
    _title = _title.replaceAll(" ", "_").replaceAll("'", "");
    return Image.asset(
      "assets/${_title}",
      scale: scale,
    );
  }
}
