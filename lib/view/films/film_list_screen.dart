import 'package:flutter/material.dart';
import 'package:ghibloo_app/utils/color.dart';
import 'package:ghibloo_app/models/film_model.dart';
import 'package:ghibloo_app/services/api_service.dart';
import 'package:ghibloo_app/view/widget/app_bar_widget.dart';
import 'package:ghibloo_app/view/widget/film_card_widget.dart';
import 'package:iconsax/iconsax.dart';

class FilmListScreen extends StatefulWidget {
  const FilmListScreen({super.key});

  @override
  State<FilmListScreen> createState() => _FilmListScreenState();
}

class _FilmListScreenState extends State<FilmListScreen> {
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
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          width: 100,
        ),
        backgroundColor: kbackgroundColor,
        actions: const [AppbarWidget(), SizedBox(width: 20)],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "GHIBLI FILMS",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Serif",
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 50,
                child: ListTile(
                  title: TextField(
                    controller: _searchController,
                    onChanged: onSearch,
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: const Icon(Iconsax.search_favorite),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Iconsax.close_circle,
                          color: Colors.pink,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          onSearch("");
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
      ),
    );
  }
}
