import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ghibloo_app/models/films_model.dart';
import 'package:ghibloo_app/services/api_service.dart';
import 'package:ghibloo_app/theme.dart';
import 'package:ghibloo_app/widget/film_card_widget.dart';
import 'package:iconsax/iconsax.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiService apiService = ApiService();
  late Future<List<FilmModel>> _filmsFuture;
  final List<FilmModel> _films = [];
  List<FilmModel> _searchResult = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    _filmsFuture = apiService.getFilms().then((films) {
      _films.addAll(films);
      return _films;
    });
  }

  void onSearch(String text) {
    if (text.isEmpty) {
      setState(() {
        _searchResult = List.from(_films);
      });
      return;
    }
    setState(() {
      _searchResult = _films
          .where(
              (film) => film.title.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Card(
                child: ListTile(
                  title: TextField(
                    controller: _searchController,
                    onChanged: onSearch,
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: const Icon(Iconsax.search_favorite),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Iconsax.close_square,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          onSearch("");
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<FilmModel>>(
                future: _filmsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else {
                    final filmsToShow = _searchResult.isNotEmpty
                        ? _searchResult
                        : snapshot.data!;

                    return ListView.separated(
                      itemCount: filmsToShow.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: FilmCardWidget(
                            film: filmsToShow[index],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
