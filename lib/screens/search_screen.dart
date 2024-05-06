import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ghibloo_app/widget/search_appbar_widget.dart';
import 'package:ghibloo_app/models/films_model.dart';
import 'package:ghibloo_app/services/api_service.dart';
import 'package:ghibloo_app/widget/film_card_widget.dart';
import 'package:ghibloo_app/widget/search_appbar_widget.dart';
import 'package:iconsax/iconsax.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiService apiService = ApiService();
  late Future<List<FilmModel>> _filmsFuture;
  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    _filmsFuture = apiService.getFilms();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.withOpacity(0.5))),
            ),
            Row(
              children: [
                const Icon(Iconsax.search_normal, color: Colors.green),
                const SizedBox(
                  width: 50,
                )
              ],
            ),
            FutureBuilder<List<FilmModel>>(
                future: _filmsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    List<FilmModel> films = snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => FilmCardWidget(
                              film: films[index],
                            ),
                            itemCount: films.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              // Add your code here
                              return SizedBox(
                                height: 15,
                              ); // Replace Container() with your desired widget
                            },
                          ),
                        ],
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    )));
  }
}
