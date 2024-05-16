import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ghibloo_app/utils/color.dart';
import 'package:ghibloo_app/models/character_model.dart';
import 'package:ghibloo_app/view/screen/films/film_list_screen.dart';
import 'package:ghibloo_app/services/api_service.dart';
import 'package:ghibloo_app/view/widget/app_bar_widget.dart';
import 'package:ghibloo_app/view/widget/character_card_widget.dart';
import 'package:iconsax/iconsax.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late Future<List<CharacterModel>> _characterListFuture;
  late List<CharacterModel> _characterList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _characterListFuture = ApiService().getCharacter();
    });
    _characterListFuture.then((characterList) {
      setState(() {
        _characterList = characterList;
      });
    }).catchError((error) {
      print('Error fetching character: $error');
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "CHARACTERS",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Serif",
                ),
              ),
              SizedBox(
                height: 50,
                child: ListTile(
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: const Icon(Iconsax.search_favorite),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Iconsax.close_circle,
                          color: Colors.pink,
                        ),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: FutureBuilder<List<CharacterModel>>(
                  future: _characterListFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: _characterList.length,
                        itemBuilder: (context, index) {
                          return characterListWidget(_characterList[index],
                              characters: []);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
